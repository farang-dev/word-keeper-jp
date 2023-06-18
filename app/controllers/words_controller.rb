require 'net/http'

class WordsController < ApplicationController
  def index
    @words = current_user.words.order(created_at: :desc)
    @word = Word.new
  end

  def create
    word_jptitle = params[:word][:jptitle]
    word_data = fetch_word_data(word_jptitle)

    @word = current_user.words.build(
      jptitle: word_jptitle,
      jpdescription: word_data[:jpdescription],
      reading: word_data[:reading],
      translations: word_data[:translations],
      word_type: word_data[:word_type]
    )

    example_sentences = word_data[:example_sentences]
    example_sentences = [] if example_sentences.empty?
    @word.example_sentences = example_sentences

    kanji_details = word_data[:kanji_details]
    kanji_details = [] if kanji_details.empty?
    @word.kanji_details = kanji_details

    respond_to do |format|
      if @word.save
        format.html { redirect_to words_path, notice: "Word was successfully created." }
        format.json { render :create, status: :created, location: @word }
      else
        format.html { render :index }
        format.json { render json: @word.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @word = current_user.words.find(params[:id])
    @word.destroy
    redirect_to words_path
  end

  def fetch_word_data(word)
    encoded_word = URI.encode_www_form_component(word)
    url = URI.parse("https://jisho.org/api/v1/search/words?keyword=#{encoded_word}")

    http = Net::HTTP.new(url.host, url.port)
    http.use_ssl = true

    request = Net::HTTP::Get.new(url.request_uri)
    response = http.request(request)
    json = JSON.parse(response.body)

    if json['data'].empty?
      return {
        jpdescription: 'No definition available',
        reading: '',
        translations: [],
        example_sentences: [],
        kanji_details: [],
        word_type: ''
      }
    end

    data = json['data'][0]
    senses = data['senses']

    jpdescription = senses&.map { |sense| sense['english_definitions'] }&.flatten&.join(', ')
    reading = data['japanese']&.map { |japanese| japanese['reading'] }&.join(', ')
    translations = senses&.map { |sense| sense['english_definitions'] }&.flatten || []
    example_sentences = []
    kanji_details = []
    word_type = senses&.map { |sense| sense['parts_of_speech'] }&.flatten&.first || ''

    senses&.each do |sense|
      next unless sense['japanese']
      sense['japanese'].each do |japanese|
        example_sentences << japanese['word'] if japanese['word']
      end
    end

    data['japanese']&.each do |japanese|
      next unless japanese['word'] && japanese['senses'] && japanese['senses'][0]
      kanji = japanese['word']
      meanings = japanese['senses'][0]['english_definitions']
      readings = japanese['reading']
      stroke_order = kanji&.gsub(/[^[:alnum:]]/, '')

      kanji_details << {
        kanji: kanji,
        meanings: meanings,
        readings: readings,
        stroke_order: stroke_order
      }
    end

    {
      jpdescription: jpdescription,
      reading: reading,
      translations: translations,
      example_sentences: example_sentences,
      kanji_details: kanji_details,
      word_type: word_type
    }
  end
end
