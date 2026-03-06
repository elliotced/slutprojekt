class Array

    def count(&blk)
        count = 0
        i = 0
        if block_given?
            while i < self.length
                if blk.call(self[i])
                    count += 1
                end
                i +=1
            end
        else
            while i < self.length
                i += 1
                count += 1
            end
            return count
        end
    end


end

p [1,2,3,6].count() {|x| x >= 3 }

