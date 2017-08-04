# define current products
@products = {
"VS5" =>
      { 3 => 6.99,
        5 => 8.99 },
"MB11" =>
      { 2 => 9.95,
        5 => 16.95,
        8 => 24.95
		  },
 "CF" =>
      { 3 => 5.95,
        5 => 9.95,
        9 => 19.99
      }
}

def packOptions(products,code)
  return products[code].keys
end

def tryPrepackList(list,total,code)
  # puts "called"
  if list.count > 1
    descList = list.sort!{|x,y| y<=>x}
    # print "descList: #{descList}, total: #{total} \n"
    # more that biggest pack number
    bigger_amount = total / descList.first
    reminder_of_bigger_pack = total % descList.first

    if reminder_of_bigger_pack > 0
      # reminder & descList[1] == 0
      if reminder_of_bigger_pack % descList[1] == 0
        small_amount = reminder_of_bigger_pack / descList[1]

        printIfExist(bigger_amount, descList.first, code)
        # puts "#{bigger_amount} x @#{descList.first} | 1"
        printIfExist(small_amount, descList[1], code)
        # puts "#{small_amount} x @#{descList[1]} | 2"
        return true
      else
      # reminder & descList[1] != 0 and need to process
        # remove first element
        new_list = descList - [descList.first]
        # deduce bigger amount
        new_total = total % descList.first
        if tryPrepackList(new_list,new_total,code)   # new_list = [5,2], new_total =
          printIfExist(bigger_amount, descList.first, code)
          # puts "#{bigger_amount} x @#{descList.first} | 3"
        else
          # roll back a the first element and recalculate total
          new_total = total
          tryPrepackList(new_list,new_total,code)
        end
      end

    elsif reminder_of_bigger_pack == 0
      # print "#{descList}\n"
      printIfExist(bigger_amount, descList.first, code)
      # puts "#{bigger_amount} x #{descList.first} | 4"
    end

  elsif list.count == 1
    if total % list.first == 0
      printIfExist(total / list.first, list.first, code)
      # puts "#{total / list.first} x @#{list.first} | 5"
      return true
    else total % list.first != 0
      return false
    end
  end
end


def printIfExist(amount, packs, code)
  if amount > 0
    puts "#{amount} x @#{packs} $ #{@products[code][packs]}"
  end
end