module FileColumn
  module Validations
    module ClassMethods

      def validates_image_size(*attrs)
        options = attrs.pop if attrs.last.is_a?Hash
        raise ArgumentError, "Please include a :max option." if !options || !options[:max]
        raise ArgumentError, "Please include a :min option." if !options || !options[:min]

        maximums = options[:max].scan(IMAGE_SIZE_REGEXP).first.collect{|n| n.to_i} rescue []
        raise ArgumentError, "Invalid value for option :max (should be 'XXxYY')" unless maximums.size == 2

        minimums = options[:min].scan(IMAGE_SIZE_REGEXP).first.collect{|n| n.to_i} rescue []  
        raise ArgumentError, "Invalid value for option :min (should be 'XXxYY')" unless minimums.size == 2

        require 'RMagick'

        validates_each(attrs, options) do |record, attr, value|
          unless value.blank?
            begin
              img = ::Magick::Image::read(value).first
              record.errors.add('image', " is too big, must be at most #{maximums[0]}x#{maximums[1]}") if ( img.rows > maximums[1] || img.columns > maximums[0] )
              record.errors.add('image', " is too small, must be at least #{minimums[0]}x#{minimums[1]}") if ( img.rows < minimums[1] || img.columns < minimums[0] )
            rescue ::Magick::ImageMagickError
              record.errors.add('image', "invalid")
            end
            img = nil
            GC.start
          end
        end
      end
    end
  end
end
