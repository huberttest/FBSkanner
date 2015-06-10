class StaticPagesController < ApplicationController
CONN = ActiveRecord::Base.connection
  def home
  	@token = "CAACEdEose0cBAPQHzjnw1sGBOPeBEboRFJY9dzQ9kQwmSqsCExBmVHyizGmt0CUfUMMlNSAoqu9l6ascQTtjdN74X8yioZAZCjKe1YaHXPcfsHOxVyDC7z0960DvqPOmAGw9BW0yPzBHFcmdYlcF94dTuiikBXmUoC8AZBODnqMhnE2XxtB1ZAepTtxN6bRc2kLiTICZCmIMRVvGkXUgunyk6CskbfsgZD"
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
