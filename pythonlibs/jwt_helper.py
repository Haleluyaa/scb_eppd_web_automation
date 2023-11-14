import jwt

def decode_jwt_token (token):
    try:
        value = jwt.decode (token, verify=False)
        return (value)
    except Exception as e:
        print (e)
        return (e)    

