module Jekyll
    class TagPageGenerator < Generator
      safe true
  
      def generate(site)
        tags = site.posts.docs.flat_map { |post| post.data['tags'] }.compact.uniq
        tags.each do |tag|
          slugified_tag = slugify(tag)
          site.pages << TagPage.new(site, site.source, slugified_tag, tag)
        end
      end
  
      # Slugify method to handle tag conversion to URL-safe format
      def slugify(input)
        input.downcase.strip.gsub(' ', '-').gsub(/[^\w-]/, '')
      end
    end
  
    class TagPage < Page
      def initialize(site, base, slugified_tag, original_tag)
        @site = site
        @base = base
        @dir = "projects/tags/#{slugified_tag}" # Directory for tag pages
        @name = "index.html"
        self.process(@name)
        self.read_yaml(File.join(base, '_layouts'), 'tags.html')
        self.data['tag'] = original_tag
        self.data['title'] = "Posts tagged: #{original_tag}"
      end
    end
  end
  