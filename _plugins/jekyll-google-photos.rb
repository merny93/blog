require "jekyll"
require 'open-uri'
require 'nokogiri'
require 'net/http'

module JekyllGooglePhotos
  class Generator < Jekyll::Generator
    def getImageLinks(url)
      doc = Nokogiri::HTML(URI.open(url.strip).read) #this was switched from open(URL) to URI.open(URL) in ruby 3.0
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
      pages = site.posts.docs.select { |page| page["gallery_url"]}
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
