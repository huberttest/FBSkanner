class StaticPagesController < ApplicationController
CONN = ActiveRecord::Base.connection

  def home
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
  end

  def update
    @auth_with_ownapphub = Koala::Facebook::OAuth.new(867013733372006, "ff8935cc1a374399d4493a3d2fa60c84")
    @token = @auth_with_ownapphub.get_app_access_token

    info = Koala::Facebook::API.new(@token)
    @getinfo1 = info.get_connections(id="270028826443166", connection_name="feed?fields=id,description,message,from,picture,comments", {:limit => 300})



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
      @description2 << (if abc["description"] != nil
                          abc["description"]
                        else
                          nil
                        end
                       )
      @linktooffer << "http://facebook.pl/" + "#{abc["id"]}"
      @updatedinfacebok << (time = abc["updated_time"].to_time + (60 * 60 * 2) ; time.strftime("%F %T"))
      @number_of_comments << ( if abc["comments"] != nil
                                 abc["comments"]["data"].count
                               else
                                 0
                               end
                             )
    end

    inserts = (1..300).to_a
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
  end
end
