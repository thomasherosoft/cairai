#+------------------------------------------------------------+
# * File Name         : search.rb
# * Application Name  : Elevator Pitch(Givid)
# * Description       : Application For Entice users to watch ads by paying them, read books/comics and get coins.
# * Developed By      : Bacancy Technology
# * Developed In      : 2015-2016
# +------------------------------------------------------------+
class Search
  
  # Common Contents for the books and comics like genre, license, age restriction
  BOOK_AND_COMIC_CONTENT_TYPES = [["Action", "action"], ["Biography", "biography"], ["Cooking, Food & Drinks", "Cooking-food-and-drinks"], ["Education", "education"], ["History", "history"], ["Horror", "horror"], ["Mystery", "mystery"], ["Religion", "religion"], ["Romance", "romance"], ["Science Fiction", "science-fiction"], ["Tragedy", "tragedy"], ["Western", "western"]]
  
  BOOK_AND_COMIC_LICENSE_TYPES = [["Cairai License (All rights Reserved)", "Cairai_license"], ["Creative Commons Attribution 4.0 (CC-BY)", "CC_Attribution"], ["Creative Commons Attribution-ShareAlike 4.0 (CC-BY-NC)", "CC_Attribution_ShareAlike"], ["Creative Commons Attribution-NoDerivs 4.0 (CC-BY-ND)", "CC_Attribution_NoDerivs"], ["Creative Commons Attribution-NonCommercial 4.0 (CC-BY-NC)", "CC_Attribution_NonCommercial"], ["Creative Commons Attribution-NonCommercial-ShareAlike 4.0 (CC-BY-NC-SA)", "CC_Attribution_NonCommercial_ShareAlike"], ["Creative Commons Attribution-NonCommercial-NoDerivs 4.0 (CC-BY-NC-ND)", "CC_Attribution_NonCommercial_NoDerivs"], ["Public Domain Mark 1.0 (CC0)", "CC_Public_Domain_Mark"]]
 
  BOOK_AND_COMIC_AGE_RESTRICTION = [["Everyone", 0], ["Age 13 and Up", 1], ["Age 17 and Up", 2]]
  
  BOOK_AND_COMIC_SEARCH_CATEGORY = [["Newest-Oldest", "newest-oldest"], ["Oldest-Newest", "oldest-newest"], ["Most Liked", "most-liked"], ["Most Disliked", "most-disliked"], ["Highest Views", "highest-views"], ["Lowest Views", "lowest-views"]]
  
  BOOK_AND_COMIC_SCHEDULE_CATEGORY = [["Live", 0], ["Schedule", 1], ["Premium Live", 2], ["Premium Scheduled", 3], ["Premium Than Live", 4]] 
  
            
  # Search the result based on the end user's inputs, and order the result with desending order
  def search_books_and_comics(search)
    search_val = search[:book]
      case search_val
      when "book"
        Book.ransack(title_cont: "#{search[:search_text]}").result.order("created_at desc")
      when "comic"
        Comic.ransack(title_cont: "#{search[:search_text]}").result.order("created_at desc")
      else
        (Book.ransack(title_cont: "#{search[:search_text]}").result + Comic.ransack(title_cont: "#{search[:search_text]}").result).sort_by(&:created_at)
      end
  end
  
  def feed_contents user_id
    (Book.ransack(user_id_eq: user_id).result + Comic.ransack(user_id_eq: user_id).result).sort_by(&:created_at)
  end
  
  # Filter the data based on the category for the books
  def filter_books_with_category(user, category)
      case category
      when "newest-oldest"
        user.books.ransack.result.order("created_at desc")
      when "oldest-newest"
        user.books.ransack.result.order("created_at asc")
      when "most-liked"
        user.books.order(:cached_votes_up => :desc)
      when "most-disliked"
        user.books.order(:cached_votes_down => :desc)
      when "highest-views"
        user.books.joins("LEFT JOIN impressions ON books.id = impressions.impressionable_id AND impressions.impressionable_type = 'Book'").inject(Hash.new(0)) { |h,v| h[v] += 1; h }.sort_by { |k, v| -v }.map(&:first)      
      else
        user.books.joins("LEFT JOIN impressions ON books.id = impressions.impressionable_id AND impressions.impressionable_type = 'Book'").inject(Hash.new(0)) { |h,v| h[v] += 1; h }.sort_by { |k, v| -v }.map(&:first).reverse
      end
  end
  
  # Filter the data based on the category for the comcis
  def filter_comics_with_category(user, category)
      case category
      when "newest-oldest"
        user.comics.ransack.result.order("created_at desc")
      when "oldest-newest"
        user.comics.ransack.result.order("created_at asc")
      when "most-liked"
        user.comics.order(:cached_votes_up => :desc)
      when "most-disliked"
        user.comics.order(:cached_votes_up => :desc)
      when "highest-views"
        user.comics.joins("LEFT JOIN impressions ON comics.id = impressions.impressionable_id AND impressions.impressionable_type = 'Comic'").inject(Hash.new(0)) { |h,v| h[v] += 1; h }.sort_by { |k, v| -v }.map(&:first)      
      else
        user.comics.joins("LEFT JOIN impressions ON comics.id = impressions.impressionable_id AND impressions.impressionable_type = 'Comic'").inject(Hash.new(0)) { |h,v| h[v] += 1; h }.sort_by { |k, v| -v }.map(&:first).reverse
      end
  end
  
  def self.licence_name resource 
    case resource.license_type
    when "Cairai_license"
      "Cairai License (All rights Reserved)"
    when "CC_Attribution"
      "Cairai License (All rights Reserved)"
    when "CC_Attribution_ShareAlike"
      "Creative Commons Attribution 4.0 (CC-BY)"
    when "CC_Attribution_NoDerivs"
      "Creative Commons Attribution-ShareAlike 4.0 (CC-BY-NC)"
    when "CC_Attribution_NonCommercial"
      "Creative Commons Attribution-NoDerivs 4.0 (CC-BY-ND)"
    when "CC_Attribution_ShareAlike"
      "Creative Commons Attribution-NonCommercial 4.0 (CC-BY-NC)" 
    when "CC_Attribution_NonCommercial_ShareAlike"
      "Creative Commons Attribution-NonCommercial-ShareAlike 4.0 (CC-BY-NC-SA)" 
    when "CC_Attribution_NonCommercial_NoDerivs"
      "Creative Commons Attribution-NonCommercial-NoDerivs 4.0 (CC-BY-NC-ND)"
    when "CC_Public_Domain_Mark"
      "Public Domain Mark 1.0 (CC0)"      
    else
      "None"
    end
  end
  
  def self.language resource
    LanguageList::LanguageInfo.find(resource.language).name
  end
  
end