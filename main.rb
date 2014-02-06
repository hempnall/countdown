numbers = [100,2,75,3,7,8]
target = 98


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

