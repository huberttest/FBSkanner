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


##Dla chcących wynająć:

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
                                    abc.description1.downcase.include?("jeśli ktoś szuka pokoju") ||
                                    (abc.description1.downcase.include?("wynajmę") if abc.description1.downcase.exclude?("szukam pok")) ||
                                    (abc.description1.downcase.include?("do wynajęcia") if (abc.description1.downcase.exclude?("poszukuję miesz") &&
                                                                                            abc.description1.downcase.exclude?("szukam pokoju") &&
                                                                                            abc.description1.downcase.exclude?("szukam do wynajęcia") &&
                                                                                            abc.description1.downcase.exclude?("poszukuję kawalerki")))

  	                           } if wynajem[:chcewynajac].present?

#pokój jednoosobowy

    miejsce = miejsce.find_all {|abc| (abc.description1.downcase.include?("szuk") ||
                                      abc.description1.downcase.include?("jakikolwiek")) &&
                                      abc.description1.downcase.include?("jednoo") ||
                                      abc.description1.downcase.include?("1os") ||
                                      (abc.description1.downcase.include?("1-os") if abc.description1.downcase.exclude?("mieszkanie")) ||
                                      abc.description1.downcase.include?("szukam pokoju do wynajęcia")





                               } if wynajem[:chce_wynajac_pokoj_jednoosobowy].present?
    miejsce = miejsce.reject {|abc| abc.description1.downcase.include?("szukamy kogo") ||
                                    abc.description1.downcase.include?("mamy do wynaj") ||
                                    abc.description1.downcase.include?("jeśli ktoś szuka") ||
                                    abc.description1.downcase.include?("poszukiwana wsp") ||
                                    abc.description1.downcase.include?("poszukiwany wsp") ||
                                    abc.description1.downcase.include?("szukamy fajnej") ||
                                    abc.description1.downcase.include?("miejsce w pokoju") ||
                                    abc.description1.downcase.include?("szukamy pary") ||
                                    abc.description1.downcase.include?("wspoll") ||
                                    abc.description1.downcase.include?("wspołl") ||
                                    abc.description1.downcase.include?("wspóll") ||
                                    abc.description1.downcase.include?("współl") ||
                                    abc.description1.downcase.include?("jeśli ktoś szuka pokoju") ||
                                    (abc.description1.downcase.include?("wynajmę") if (abc.description1.downcase.exclude?("szukam pok") ||
                                                                                       abc.description1.downcase.exclude?("1 os"))) ||
                                    (abc.description1.downcase.include?("do wynajęcia") if (abc.description1.downcase.exclude?("poszukuję miesz") &&
                                                                                            abc.description1.downcase.exclude?("szukam pokoju") &&
                                                                                            abc.description1.downcase.exclude?("szukam do wynajęcia") &&
                                                                                            abc.description1.downcase.exclude?("poszukuję kawalerki")))

                               } if wynajem[:chce_wynajac_pokoj_jednoosobowy].present?

#pokój jednoosobowy

#pokój dwuosobowy

    miejsce = miejsce.find_all {|abc| (abc.description1.downcase.include?("szuk") && abc.description1.downcase.include?("dwuos") && abc.description1.downcase.exclude?("szukam pokoju jednoosobowego") && abc.description1.downcase.exclude?("do współdzielenia")) ||
                                      (abc.description1.downcase.include?("jakikolwiek") && abc.description1.downcase.exclude?("jednoos")) ||
                                       abc.description1.downcase.include?("z dziewczyną szukamy pokoju") ||
                                       abc.description1.downcase.include?("z chłopakiem szukamy pokoju") ||
                                       (abc.description1.downcase.include?("2-os") && abc.description1.downcase.include?("szuk"))
                               } if wynajem[:chce_wynajac_pokoj_dwuosobowy].present?
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
                                    abc.description1.downcase.include?("jeśli ktoś szuka pokoju") ||
                                    (abc.description1.downcase.include?("wynajmę") if abc.description1.downcase.exclude?("szukam pok")) ||
                                    (abc.description1.downcase.include?("do wynajęcia") if (abc.description1.downcase.exclude?("poszukuję miesz") &&
                                                                                            abc.description1.downcase.exclude?("szukam pokoju") &&
                                                                                            abc.description1.downcase.exclude?("szukam do wynajęcia") &&
                                                                                            abc.description1.downcase.exclude?("poszukuję kawalerki")))

                               } if wynajem[:chce_wynajac_pokoj_dwuosobowy].present?

#pokój dwuosobowy

#kawalerka lub mieszkanie


    miejsce = miejsce.find_all {|abc| (abc.description1.downcase.include?("szuk") if abc.description1.downcase.include?("kawaler")) ||
                                       abc.description1.downcase.include?("szukam mieszkania") ||
                                       abc.description1.downcase.include?("[szukam] mieszkania") ||
                                       abc.description1.downcase.include?("poszukuję mieszkania") ||
                                       abc.description1.downcase.include?("poszukuje mieszkania") ||
                                       abc.description1.downcase.include?("poszukiwane mieszkanie") ||
                                       abc.description1.downcase.include?("szukaja mieszkania") ||
                                       abc.description1.downcase.include?("szukamy mieszkania")
                               } if wynajem[:chce_wynajac_kawalerke_mieszkanie].present?

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
                                    abc.description1.downcase.include?("jeśli ktoś szuka pokoju") ||
                                    (abc.description1.downcase.include?("wynajmę") if abc.description1.downcase.exclude?("szukam pok")) ||
                                    (abc.description1.downcase.include?("do wynajęcia") if (abc.description1.downcase.exclude?("poszukuję miesz") &&
                                                                                            abc.description1.downcase.exclude?("szukam pokoju") &&
                                                                                            abc.description1.downcase.exclude?("szukam do wynajęcia") &&
                                                                                            abc.description1.downcase.exclude?("poszukuję kawalerki")))

                               } if wynajem[:chce_wynajac_kawalerke_mieszkanie].present?
#kawalerka lub mieszkanie

#miejsce w pokoju

    miejsce = miejsce.find_all {|abc| (abc.description1.downcase.include?("szuk") && abc.description1.downcase.include?("miejsca w pokoju")) ||
                                      abc.description1.downcase.include?("jakikolwiek")

                               } if wynajem[:chce_znalezc_miejsce_w_pokoju].present?
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
                                    abc.description1.downcase.include?("jeśli ktoś szuka pokoju") ||
                                    (abc.description1.downcase.include?("wynajmę") if abc.description1.downcase.exclude?("szukam pok")) ||
                                    (abc.description1.downcase.include?("do wynajęcia") if (abc.description1.downcase.exclude?("poszukuję miesz") &&
                                                                                            abc.description1.downcase.exclude?("szukam pokoju") &&
                                                                                            abc.description1.downcase.exclude?("szukam do wynajęcia") &&
                                                                                            abc.description1.downcase.exclude?("poszukuję kawalerki")))

                               } if wynajem[:chce_znalezc_miejsce_w_pokoju].present?


#miejsce w pokoju

  	miejsce
  end
end
