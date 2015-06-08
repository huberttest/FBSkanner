class StaticPagesController < ApplicationController
CONN = ActiveRecord::Base.connection
  def home
  	@token = "CAACEdEose0cBAJ8fozCdOrsZAMxtXgfyMniPwBy9sRjLhmbZAFMDXQVaDB3QKy7SllL5nrDVudbBdv6YR3assIFEkCdlSKb8k53bkBLZAUNnqNEGHW9aLZAcamPyZBa2HLC4HvvosrfO2bBRhvw2GaigKDoCC4SrFGrNVh8CXIBvEIJ1mFZATcNfaGcpiSnZApiZCHLVllJTK1gt04DqH9t3ZCrAbyefTo2oZD"
  	info = Koala::Facebook::API.new(@token)
    @getinfo1 = info.get_connections(id="270028826443166", connection_name="feed?fields=id,name,message,from,picture", {:limit => 100})
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

@getinfo1.each do |abc|
  @userphoto << "https://graph.facebook.com/" + "#{abc["from"]["id"]}" + "/picture?type=square"
  @username << abc["from"]["name"]
  @adsphoto << "#{abc["picture"]}"
  @description1 << (abc["message"].gsub("'", "") if abc["message"] != nil)
  @description2 << abc["name"]
  @linktooffer << "http://facebook.pl/" + "#{abc["id"]}"
  @updatedinfacebok << abc["updated_time"]
end

inserts = (1..100).to_a
inserts.each_with_index do |abc, index|
  sql = "UPDATE wroclaw_pokoje_wynajems SET userphoto='#{@userphoto[index]}',
                                            username='#{@username[index]}',
                                            adsphoto='#{@adsphoto[index]}',
                                            description1='#{@description1[index]}',
                                            description2='#{@description2[index]}',
                                            linktooffer='#{@linktooffer[index]}',
                                            updatedinfacebok='#{@updatedinfacebok[index]}'
                                                                               WHERE id=#{index+1}"
CONN.execute sql
end
# zapis do bazy danych rekordy z facebook druga metoda
  end
end
