def getUserToken
  url = URI(get_config_data("API_BASE_URL") + "/auth/login")
  
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true
  
  request = Net::HTTP::Post.new(url)
  request["Content-Type"] = "application/json"
  request.body = JSON.dump({
    "username": get_config_data("VALID_USERNAME"),
    "password": get_config_data("VALID_PASSWORD")
  })
  
  response = https.request(request)
  object = JSON.parse(response.read_body, object_class: OpenStruct)
  return object.data.token
end


def getCancelOrder
  url = URI(get_config_data("API_BASE_URL") + "/cancel/orders")
  
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true
    
  request = Net::HTTP::Delete.new(url)
  request["Content-Type"] = "application/json"
  request.body = JSON.dump({
   "member_id": get_config_data("MEMBER_ID")
  })
    
  response = https.request(request)
  return JSON.parse(response.read_body, object_class: OpenStruct)
end



def getEmptyCart
  url = URI(get_config_data("API_BASE_URL") + "/delete/cart")
  
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true

  request = Net::HTTP::Delete.new(url)
  request["Content-Type"] = "application/json"
  request.body = JSON.dump({
  "member_id": get_config_data("MEMBER_ID")
  })

  response = https.request(request)
  return JSON.parse(response.read_body, object_class: OpenStruct)
end

def getMemberId
  url = URI(get_config_data("API_BASE_URL_ACCOUNT") + "/memberinfo")
  
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true
    
  request = Net::HTTP::Post.new(url)
  request["Content-Type"] = "application/json"
  request.body = JSON.dump({
    "input": get_config_data("MEMBER_ID_REGIST")
  })
    
  response = https.request(request)
  return JSON.parse(response.read_body, object_class: OpenStruct)
end

def getDeactivateAccount
  member = getMemberId
  puts member
  url = URI(get_config_data("API_BASE_URL_ACCOUNT") + "/deactivate/accounts")
  
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true
    
  request = Net::HTTP::Delete.new(url)
  request["Content-Type"] = "application/json"
  request.body = JSON.dump({
   "member_id": member.data.member_id
  })
  puts request.body
  response = https.request(request)
  return JSON.parse(response.read_body, object_class: OpenStruct)
end

def getMemberIdNoHp
  url = URI(get_config_data("API_BASE_URL_ACCOUNT") + "/memberinfo")
  
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true
    
  request = Net::HTTP::Post.new(url)
  request["Content-Type"] = "application/json"
  request.body = JSON.dump({
    "input": get_config_data("MEMBER_ID_REGIST_NOHP")
  })
    
  response = https.request(request)
  return JSON.parse(response.read_body, object_class: OpenStruct)
end

def getDeactivateAccountNoHP
  member = getMemberIdNoHp
  puts member
  url = URI(get_config_data("API_BASE_URL_ACCOUNT") + "/deactivate/accounts")
  
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = true
    
  request = Net::HTTP::Delete.new(url)
  request["Content-Type"] = "application/json"
  request.body = JSON.dump({
   "member_id": member.data.member_id
  })
  puts request.body
  response = https.request(request)
  return JSON.parse(response.read_body, object_class: OpenStruct)
end


# ================== PROD ======================

def getUserTokenProd
  url = URI(get_config_data("API_BASE_URL") + "/auth/login")
  
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = false
  
  request = Net::HTTP::Post.new(url)
  request["Content-Type"] = "application/json"
  request.body = JSON.dump({
    "username": get_config_data("VALID_USERNAME"),
    "password": get_config_data("VALID_PASSWORD")
  })
  
  response = https.request(request)
  object = JSON.parse(response.read_body, object_class: OpenStruct)
  return object.data.token
end


def getCancelOrderProd
  url = URI(get_config_data("API_BASE_URL") + "/cancel/orders")
  
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = false
    
  request = Net::HTTP::Delete.new(url)
  request["Content-Type"] = "application/json"
  request.body = JSON.dump({
   "member_id": get_config_data("MEMBER_ID")
  })
    
  response = https.request(request)
  return JSON.parse(response.read_body, object_class: OpenStruct)
end



def getEmptyCartProd
  url = URI(get_config_data("API_BASE_URL") + "/delete/cart")
  
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = false

  request = Net::HTTP::Delete.new(url)
  request["Content-Type"] = "application/json"
  request.body = JSON.dump({
  "member_id": get_config_data("MEMBER_ID")
  })

  response = https.request(request)
  return JSON.parse(response.read_body, object_class: OpenStruct)
end

def getMemberIdProd
  url = URI(get_config_data("API_BASE_URL_ACCOUNT") + "/memberinfo")
  
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = false
    
  request = Net::HTTP::Post.new(url)
  request["Content-Type"] = "application/json"
  request.body = JSON.dump({
    "input": get_config_data("MEMBER_ID_REGIST")
  })
    
  response = https.request(request)
  return JSON.parse(response.read_body, object_class: OpenStruct)
end

def getDeactivateAccountProd
  member = getMemberIdProd
  puts member
  url = URI(get_config_data("API_BASE_URL_ACCOUNT") + "/deactivate/accounts")
  
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = false
    
  request = Net::HTTP::Delete.new(url)
  request["Content-Type"] = "application/json"
  request.body = JSON.dump({
   "member_id": member.data.member_id
  })
  puts request.body
  response = https.request(request)
  return JSON.parse(response.read_body, object_class: OpenStruct)
end

def getMemberIdNoHpProd
  url = URI(get_config_data("API_BASE_URL_ACCOUNT") + "/memberinfo")
  
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = false
    
  request = Net::HTTP::Post.new(url)
  request["Content-Type"] = "application/json"
  request.body = JSON.dump({
    "input": get_config_data("MEMBER_ID_REGIST_NOHP")
  })
    
  response = https.request(request)
  return JSON.parse(response.read_body, object_class: OpenStruct)
end

def getDeactivateAccountNoHPProd
  member = getMemberIdNoHpProd
  puts member
  url = URI(get_config_data("API_BASE_URL_ACCOUNT") + "/deactivate/accounts")
  
  https = Net::HTTP.new(url.host, url.port)
  https.use_ssl = false
    
  request = Net::HTTP::Delete.new(url)
  request["Content-Type"] = "application/json"
  request.body = JSON.dump({
   "member_id": member.data.member_id
  })
  puts request.body
  response = https.request(request)
  return JSON.parse(response.read_body, object_class: OpenStruct)
end




