module AgCalDAV
  module XmlRequestBuilder

    class PostSharing < Base
      attr_accessor :adds, :removes, :summary, :privilege, :common_name

      def initialize(adds = nil, summary = nil, common_name = nil, privilege = nil, removes = nil)
        @adds = adds || []
        @summary = summary
        @privilege = privilege
        @common_name = common_name
        @removes = removes || []
        super()
      end

      def to_xml
        xml.cs :share, SHARING_NAMESPACES do
          unless adds.empty?
            adds.each do |add|
              add = "mailto:#{add}"
              xml.cs :set do
                xml.d :href, add
                xml.cs :summary, summary unless summary.nil?
                xml.tag! "cs:common-name", common_name unless common_name.nil?
                xml.tag! "cs:#{privilege}"
              end
            end
          end
          unless removes.empty?
            removes.each do |remove|
              remove = "mailto:#{remove}"
              xml.cs :remove do
                xml.d :href, remove
              end
            end
          end
        end
      end
    end
  end
end
