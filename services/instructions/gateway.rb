require_relative '../../infrastructure/s3'

module Instructions
  class Gateway
    class << self
      def obtain_instructions
        {
          'url' => generate_url,
          'method' => 'PUT'
        }
      end

      private

      def generate_url
        filename = 'test.txt'
        object = s3_resource.bucket(bucket).object(filename)
        url = URI.parse(object.presigned_url(:put))
        url
      end

      def s3_resource
        Infrastructure::S3.resource
      end

      def bucket
        Infrastructure::S3.bucket
      end
    end
  end
end