require 'test/unit'
extend Test::Unit::Assertions

class BankOCR
  def initialize(filename)
    file = File.open(filename, "r")
    data = file.read
    file.close

    @accounts = data.split("\n")
    @accounts << ""
  end

  def get_accounts()
    count = @accounts.length
    start_pos = 0
    end_pos = 3
    result = []

    while end_pos < count
      result << print_account(@accounts[start_pos..end_pos]).join
      start_pos += 4
      end_pos += 4
    end

    result
  end

  def print_account(lcd_string)
    account_lines = lcd_string.map(&:chomp)
    start_pos = 0
    end_pos = 2
    line_number = 0
    digit_position = 0
    result = []

    while end_pos < 27
      while line_number < 3
        if line_number == 0
          result[digit_position] = [account_lines[line_number][start_pos..end_pos]]
        else
          result[digit_position] << [account_lines[line_number][start_pos..end_pos]]
        end
        line_number += 1
      end
      digit_position += 1
      line_number = 0
      start_pos += 3
      end_pos += 3
    end

    result.map! do |num|
      case num.join
      when  " _ " +
            "| |" +
            "|_|"
            "0"
      when  "   " +
            "  |" +
            "  |"
            "1"
      when  " _ " +
            " _|" +
            "|_ "
            "2"
      when  " _ " +
            " _|" +
            " _|"
            "3"
      when  "   " +
            "|_|" +
            "  |"
            "4"
      when  " _ " +
            "|_ " +
            " _|"
            "5"
      when  " _ " +
            "|_ " +
            "|_|"
            "6"
      when  " _ " +
            "  |" +
            "  |"
            "7"
      
      when  " _ " +
            "|_|" +
            "|_|"
            "8"
      
      when  " _ " +
            "|_|" +
            " _|"
            "9"
      end
    end
    result
  end
end

bank = BankOCR.new("accounts.txt")
result1 = bank.get_accounts

p assert_equal result1, ["000000000","111111111","222222222","333333333","444444444","555555555","666666666","777777777","888888888","999999999","123456789"]