numbers = [62,12,7,1,5,10]
target = 130


if ARGV.length != 7
	puts "incorrect number of arguments"
	puts "main.rb  n1 n2 n3 n4 n5 n6 target"
	puts "e.g. main.rb  62 12 7 1 5 10 130"
	exit
end 


target = ARGV[6].to_i
numbers_str = ARGV.slice(0,6)
numbers =  numbers_str.collect{|i| i.to_i}  

def remove_numbers(arr,numa,numb)
	arr.delete_at(arr.index(numa) || arr.length)
	arr.delete_at(arr.index(numb) || arr.length)
	return arr
end

def evaluate_array(arr,newitem,targ,leng,opstack,op)

	opstack.push op

	earr = arr.dup
	earr = earr.concat(newitem)
	combos = earr.combination(2);
	
	if earr.length != leng
		puts "unexpected array size #{earr.length} != #{leng}"
		gets 
	end 
	
#	puts combos
	

	# we need a better way of detecting whether we have reached the target - i dont think 
	# this will catch every case :-(
	if earr.index(targ)
		puts "---------"
		puts opstack.inspect
		puts "---------"
		opstack.pop
		return
	end


	
	combos.each do |c|


		next_array = remove_numbers(earr.dup,c[0],c[1])

		test = c[0] + c[1]
		 
		evaluate_array(next_array,[test],targ,leng-1,opstack,"#{c[0]} + #{c[1]} = #{test}")
		
		test = c[0] * c[1]
		evaluate_array(next_array,[test],targ,leng-1,opstack,"#{c[0]} * #{c[1]} = #{test}")


		test = c[0] - c[1]
		evaluate_array(next_array,[test],targ,leng-1,opstack,"#{c[0]} - #{c[1]} = #{test}")

		#test = c[1] - c[0]
		#evaluate_array(next_array,[test],targ,leng-1,opstack,"#{c[1]} - #{c[0]} = #{test}")

		if c[0] !=0 and c[1] % c[0] == 0  
			test = c[1] / c[0]
			evaluate_array(next_array,[test],targ,leng-1,opstack,"#{c[1]} / #{c[0]} = #{test}")
		end

		if c[1] != 0 and c[0] % c[1] == 0 
			test = c[0] / c[1]
			evaluate_array(next_array,[test],targ,leng-1,opstack,"#{c[0]} / #{c[1]} = #{test}")
		end


	end

	opstack.pop

	return 

end


evaluate_array(numbers,[],target,numbers.length,[],"")

