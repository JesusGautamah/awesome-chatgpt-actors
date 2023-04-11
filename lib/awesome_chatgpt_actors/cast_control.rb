# frozen_string_literal: true

module AwesomeChatgptActors
  # This class is responsible to control the actors csv file
  class CastControl
    def self.csv_path
      ENV.fetch("CAST_CSV_NAME", "prompts-data/awesome-chatgpt-prompts.csv")
    end

    def self.temp_path
      ENV.fetch("CAST_TEMP_NAME", "temp.csv")
    end

    def self.actors_csv
      raise "The csv file does not exist" unless File.exist?(csv_path)

      @actors_csv = CSV.read(csv_path, headers: true, quote_char: '"', col_sep: ",", row_sep: :auto)
    end

    def self.actors
      raise "The csv file does not exist" unless File.exist?(csv_path)

      actors_csv.map { |row| row["act"] }.uniq
    end

    def self.add_actor(actor: nil, prompt: nil)
      raise "The actor already exists" if actor_exist?(actor: actor)

      CSV.open(csv_path, "a", headers: true, quote_char: '"', col_sep: ",", force_quotes: true) do |csv|
        csv << [actor, prompt]
      end
    end

    def self.actor_exist?(actor: nil)
      raise "The actor is nil" if actor.nil?
      raise "The csv file does not exist" unless File.exist?(csv_path)

      act_column_to_array = actors_csv.map { |row| row["act"] }
      act_column_to_array.include? actor
    end

    def self.remove_actor(actor: nil)
      raise "The actor does not exist" unless actor_exist?(actor: actor)

      actors_csv.delete_if { |row| row["act"] == actor }
      CSV.open(temp_path, "w", headers: true, quote_char: '"', col_sep: ",", force_quotes: true) do |csv|
        csv << %w[act prompt]
        actors_csv.each { |row| csv << row unless row["act"] == actor }
      end
      FileUtils.mv(temp_path, csv_path)
    end
  end
end
