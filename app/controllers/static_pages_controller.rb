class StaticPagesController < ApplicationController
CONN = ActiveRecord::Base.connection
  def home
  	@token = "CAACEdEose0cBAI7wNpf8eSWRLXvDF3RRCafjPqvfIBtRb9VKft7uq5PTekjpfRXEQ9Ngx8CdRSwKX0i3NQ1w6GJmcZA1LZAy1UjBpoCZBwAviKkzzWPv5NB4BCDVnvdGtZAKCLuZAuPFCUHfLecsZCJjwRs4lR6ZBLdojFBWw0Hzpj6PW4bO6TO2NYxr7mawXRmD0GvvyqTJJMaZAFFZCdiT8LcfuKUQU6z8ZD"
  	info = Koala::Facebook::API.new(@token)
    @getinfo1 = info.get_connections(id="270028826443166", connection_name="feed?fields=id,description,message,from,picture,comments", {:limit => 100})
    @getall = WroclawPokojeWynajem.search(params)



    # @getall = WroclawPokojeWynajem.all.sort



# zapis do bazy danych rekordy z facebook
    # @getinfo1.each_with_index do |abc, index|
    #   if WroclawPokojeWynajem.all.sort[index] != nil
    #     WroclawPokojeWynajem.all.sort[index].update(userphoto: "https://graph.facebook.com/" + "#{abc["from"]["id"]}" + "/picture?type=square",
    # 	                                              username: abc["from"]["name"],
    # 	                                              adsphoto: "#{abc["picture"]}",
    # 	                                              description1: abc["message"],
    # 	                                              description2: abc["name"],
    # 	                                              linktooffer: "http://facebook.pl/" + "#{abc["id"]}",
    #                                                 updatedinfacebok: abc["updated_time"])
    #   else
    #     WroclawPokojeWynajem.create
    #     WroclawPokojeWynajem.all.sort[index].update(userphoto: "https://graph.facebook.com/" + "#{abc["from"]["id"]}" + "/picture?type=square",
    #                                                 username: abc["from"]["name"],
    #                                                 adsphoto: "#{abc["picture"]}",
    #                                                 description1: abc["message"],
    #                                                 description2: abc["name"],
    #                                                 linktooffer: "http://facebook.pl/" + "#{abc["id"]}",
    #                                                 updatedinfacebok: abc["updated_time"])
    #   end
    # end
# zapis do bazy danych rekordy z facebook


# zapis do bazy danych rekordy z facebook druga metoda
@userphoto = []
@username = []
@adsphoto = []
@description1 = []
@description2 = []
@linktooffer = []
@updatedinfacebok = []
@number_of_comments = []

@getinfo1.each do |abc|
  @userphoto << "https://graph.facebook.com/" + "#{abc["from"]["id"]}" + "/picture?type=square"
  @username << abc["from"]["name"]
  @adsphoto << "#{abc["picture"]}"
  @description1 << ( if abc["message"] != nil
                       abc["message"].gsub("'", "")
                     else
                       nil
                     end
                   )
  @description2 << abc["description"]
  @linktooffer << "http://facebook.pl/" + "#{abc["id"]}"
  @updatedinfacebok << abc["updated_time"].to_time.strftime("%F %T")
  @number_of_comments << ( if abc["comments"] != nil
                             abc["comments"]["data"].count
                           else
                             0
                           end
                         )
end

inserts = (1..100).to_a
inserts.each_with_index do |abc, index|
  sql = "UPDATE wroclaw_pokoje_wynajems SET userphoto='#{@userphoto[index]}',
                                            username='#{@username[index]}',
                                            adsphoto='#{@adsphoto[index]}',
                                            description1='#{@description1[index]}',
                                            description2='#{@description2[index]}',
                                            linktooffer='#{@linktooffer[index]}',
                                            updatedinfacebok='#{@updatedinfacebok[index]}',
                                            number_of_comments='#{@number_of_comments[index]}'
                                                                               WHERE id=#{index+1}"
CONN.execute sql
end
# zapis do bazy danych rekordy z facebook druga metoda
  end
end
