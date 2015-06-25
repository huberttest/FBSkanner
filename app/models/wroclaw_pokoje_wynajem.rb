class WroclawPokojeWynajem < ActiveRecord::Base

  def self.search(wynajem)
  	miejsce = WroclawPokojeWynajem.all.sort
    miejsce = miejsce.reject {|abc| abc.description1.downcase.include?("sold") ||
                                    # abc.description1.downcase.include?("lenk")  - dorobić description2
                                    abc.description1.downcase.include?("jako admin tej")
                            }

#dwuosobowy
  	miejsce = miejsce.find_all {|abc| abc.description1.downcase.include?("dwuos") ||
  	                                  abc.description1.downcase.include?("par") ||
  	                                  abc.description1.downcase.include?("dwójka") ||
  	                                  abc.description1.downcase.include?("dwojka") ||
  	                                  abc.description1.downcase.include?("dla 2 osób") ||
  	                                  abc.description1.downcase.include?("dla dwóch osób") ||
  	                                  abc.description1.downcase.include?("2-osob") ||
  	                                  abc.description1.downcase.include?("pokój 2os") ||
  	                                  abc.description1.downcase.include?("2 osobowy") ||
  	                                  abc.description1.downcase.include?("2osobowy") ||
  	                                  abc.description1.downcase.include?("2-osób") ||
  	                                  abc.description1.downcase.include?("2-OSOBOWEGO POKOJU") ||
  	                                  abc.description1.downcase.include?("pokój 2os") ||
  	                                  abc.description1.downcase.include?("Pokój 2 os") ||
  	                                  abc.description1.downcase.include?("Pokoj 2 os")
  	                           } if wynajem[:dwuosobowy].present?
#dwuosobowy

#ludzie szukający pokoju(mieszkania) lub kogoś do pokoju
  	miejsce = miejsce.find_all {|abc| abc.description1.downcase.include?("szuk") ||
                                      abc.description1.downcase.include?("jakikolwiek")
  	                           } if wynajem[:chcewynajac].present?
  	miejsce = miejsce.reject {|abc| abc.description1.downcase.include?("szukamy kogo") ||
                                    abc.description1.downcase.include?("mamy do wynaj") ||
                                    abc.description1.downcase.include?("poszukiwana wsp") ||
                                    abc.description1.downcase.include?("poszukiwany wsp") ||
                                    abc.description1.downcase.include?("szukamy fajnej") ||
                                    abc.description1.downcase.include?("miejsce w pokoju") ||
                                    abc.description1.downcase.include?("szukamy pary") ||
                                    abc.description1.downcase.include?("wspoll") ||
                                    abc.description1.downcase.include?("wspołl") ||
                                    abc.description1.downcase.include?("wspóll") ||
                                    abc.description1.downcase.include?("współl") ||
                                    (abc.description1.downcase.include?("wynajmę") if abc.description1.downcase.exclude?("szukam pok")) ||
                                    (abc.description1.downcase.include?("do wynajęcia") if (abc.description1.downcase.exclude?("poszukuję miesz") &&
                                                                                            abc.description1.downcase.exclude?("szukam pokoju") &&
                                                                                            abc.description1.downcase.exclude?("szukam do wynajęcia") &&
                                                                                            abc.description1.downcase.exclude?("poszukuję kawalerki")))

  	                           } if wynajem[:chcewynajac].present?
#chcewynajac


# Miejsce w pokoju

  	miejsce
  end
end
