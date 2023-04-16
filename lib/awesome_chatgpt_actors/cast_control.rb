# frozen_string_literal: true

module AwesomeChatgptActors
  # This class is responsible to control the actors csv file
  class CastControl
    def self.csv_path
      ENV.fetch("CAST_CSV_NAME", "prompts-data/awesome-en-prompts.csv")
    end

    def self.pt_csv_path
      ENV.fetch("CAST_PT_CSV_NAME", "prompts-data/awesome-pt-prompts.csv")
    end

    def self.temp_path
      ENV.fetch("CAST_TEMP_NAME", "temp.csv")
    end

    def self.actors_csv
      raise "The csv file does not exist" unless File.exist?(csv_path)

      @actors_csv = CSV.read(csv_path, headers: true, quote_char: '"', col_sep: ",", row_sep: :auto)
    end

    def self.actors_pt_csv
      raise "The csv file does not exist" unless File.exist?(pt_csv_path)

      @actors_pt_csv = CSV.read(pt_csv_path, headers: true, quote_char: '"', col_sep: ",", row_sep: :auto)
    end

    def self.actors
      raise "The csv file does not exist" unless File.exist?(csv_path)

      actors_csv.map { |row| row["act"] }.uniq
    end

    def self.actors_pt
      raise "The csv file does not exist" unless File.exist?(pt_csv_path)

      actors_pt_csv.map { |row| row["act"] }.uniq
    end

    def self.add_actor(actor: nil, prompt: nil, has_placeholder: false, accertivity: 1, default_frequency: 0, default_presence: 0, language: "en")
      file_path = csv_path if language == "en"
      file_path = pt_csv_path if language == "pt"

      raise "The actor is nil" if actor.nil?
      raise "The prompt is nil" if prompt.nil?
      raise "File path is nil" if file_path.nil?
      raise "The csv file does not exist" unless File.exist?(file_path)
      raise "The actor already exists" if actor_exist?(actor: actor)

      CSV.open(file_path, "a", headers: true, quote_char: '"', col_sep: ",", force_quotes: true) do |csv|
        csv << [actor, prompt, has_placeholder, accertivity, default_frequency, default_presence]
      end
    end

    def self.actor_exist?(actor: nil)
      raise "The actor is nil" if actor.nil?
      raise "The csv file does not exist" unless File.exist?(csv_path)

      act_column_to_array = actors_csv.map { |row| row["act"] }
      act_column_to_array.include? actor
    end

    def self.actor_exist_in_pt?(actor: nil)
      raise "The actor is nil" if actor.nil?
      raise "The csv file does not exist" unless File.exist?(pt_csv_path)

      act_column_to_array = actors_pt_csv.map { |row| row["act"] }
      act_column_to_array.include? actor
    end

    def self.remove_actor(actor: nil, language: "en")
      file_path = csv_path if language == "en"
      file_path = pt_csv_path if language == "pt"

      raise "The actor is nil" if actor.nil?
      raise "File path is nil" if file_path.nil?
      raise "The csv file does not exist" unless File.exist?(file_path)
      (raise "The actor does not exist" unless actor_exist?(actor: actor)) if language == "en"
      (raise "The actor does not exist" unless actor_exist_in_pt?(actor: actor)) if language == "pt"

      actors_csv.delete_if { |row| row["act"] == actor } if language == "en"
      actors_pt_csv.delete_if { |row| row["act"] == actor } if language == "pt"
      CSV.open(temp_path, "w", headers: true, quote_char: '"', col_sep: ",", force_quotes: true) do |csv|
        csv << %w[act prompt has_placeholder accertivity default_frequency default_presence]
        actors_csv.each { |row| csv << row unless row["act"] == actor } if language == "en"
        actors_pt_csv.each { |row| csv << row unless row["act"] == actor } if language == "pt"
      end
      FileUtils.mv(temp_path, file_path)
    end
  end
end
