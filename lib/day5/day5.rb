# frozen_string_literal: true

class Day5
  class << self
    def get_my_seat_id(file: 'lib/day5/input')
      seat_ids = all_seat_ids(file)

      seat_ids.each_with_index do |seat_id, index|
        higher_id = seat_ids[index + 1]

        break unless higher_id

        return seat_id + 1 if (higher_id - seat_id) != 1
      end
    end

    def highest_seat_id(file: 'lib/day5/input')
      all_seat_ids(file).last
    end

    private

    def all_seat_ids(file)
      lines = get_lines(file)

      lines.map do |line|
        line_to_seat_id(line)
      end.sort
    end

    def line_to_column(line)
      column_markers = line[7..10]

      determine_seat(markers: column_markers, first: 0, last: 7, first_char: 'R', last_char: 'L')
    end

    def line_to_row(line)
      row_markers = line[0...7]

      determine_seat(markers: row_markers, first: 0, last: 127, first_char: 'B', last_char: 'F')
    end

    def determine_seat(markers:, first:, last:, first_char:, last_char:)
      markers.each_char do |char|
        case char
        when first_char then first += ((last - first) / 2 + 1)
        when last_char then last -= ((last - first) / 2 + 1)
        end
      end

      first
    end

    def line_to_seat_id(line)
      row = line_to_row(line)
      column = line_to_column(line)

      row * 8 + column
    end

    def get_lines(file = 'lib/day5/input')
      File.read(file).lines.map(&:strip)
    end
  end
end
