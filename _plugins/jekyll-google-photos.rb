require "jekyll"
require 'open-uri'
require 'nokogiri'
require 'net/http'

module JekyllGooglePhotos
  class Generator < Jekyll::Generator
    def getImageLinks(url)
      doc = Nokogiri::HTML(open(url.strip).read)
      scripts = doc.xpath("//script")
      jsonString = ""
      for x in scripts do
        if x.inner_html.match(/initDataCallback\(/)
          jsonString = x.inner_html
          jsonString = jsonString.scan(/\[\"(https:\/\/\w+?\.googleusercontent\.com\/[^((?!\/a\/).)*$].+?)\"/)
        end
      end
      return jsonString
    end

    
    def generate(site)
      Jekyll.logger.info site.posts
      pages = site.posts.docs.select { |page| page["gallery_url"]}
      Jekyll.logger.info pages
      for page in pages
          fullLinks = []
          imageLinks = getImageLinks(page["gallery_url"].strip)
          for link in imageLinks
            fullLinks.push(link)
          end
          page.data["image_urls"] = fullLinks.uniq       
      end
    end
  end
end
