//
//  Constants.h
//  sgs
//
//  Created by Rone Loza on 4/24/17.
//  Copyright © 2017 Novit. All rights reserved.
//

#import <UIKit/UIKit.h>

#ifndef Constants_h
#define Constants_h


#endif /* Constants_h */

/**
 Constants
 **/

#define kParamIdNotiType @"4"
#define kParamIdNotiDays @"5"
#define kParamIdMenuDays @"6"

#define kNetworkDefaultTimeoutSeconds 60

/** Segue, StoryBoard Identifier **/

#define kStoryboardMain @"Main"
#define kStoryboardIdentifierHomeTabBarVC @"BaseTabBarViewController"
#define kStoryboardIdentifierHomeNavVC @"BaseNavigationViewController"

#define kStoryboardIdentifierHomeNavVC @"BaseNavigationViewController"
#define kStoryboardIdentifierSigninVC @"SignViewController"
#define kStoryboardIdentifierCountryVC @"ChooseCountryViewController"
#define kStoryboardIdentifierFirstVC @"FirstViewController"
#define kStoryboardIdentifierTermsVC @"TermsViewController"
#define kStoryboardIdentifierSettingsVC @"SettingsTableViewController"
#define kStoryboardIdentifierColsTVC @"ColsTableViewController"
#define kStoryboardIdentifierProfileVC @"ProfileViewController"
#define kStoryboardIdentifierContactVC @"ContactViewController"
#define kStoryboardIdentifierGeneralVC @"GeneralViewController"

#define kStoryboardIdentifierCustomPVC @"CustomPageViewController"

#define kStoryboardIdentifierMenuDetailInfoVC @"MenuDetailInfoViewController"
#define kStoryboardIdentifierAttachmentVC @"AttachmentViewController"

#define kStoryboardIdentifierOfficeVC @"OfficeViewController"

#define kStoryboardIdentifierNotificationDetailVC @"NotificationDetailViewController"

#define kStoryboardIdentifierWebViewController @"WebViewController"

/* JSON */

#define kJsonKeyAccessToken @"access_token"
#define kJsonKeyUserInfo @"user_info"

/* PREFS */

#define kPrefsKeyLang @"prefs_language"
#define kPrefsKeyLangName @"prefs_language_name"
#define kPrefsKeyCountry @"prefs_country"
#define kPrefsKeyCountryName @"prefs_country_name"
#define kPrefsKeyUserId @"prefs_userId"
#define kPrefsKeyUserTermnAccept @"prefs_accept_terms"
#define kPrefsKeyHost @"prefs_host"
#define kPrefUserLoged @"prefs_userLogged"
#define kPrefUserCountryImageStringBase64 @"prefs_country_string_64"

#define kPrefUserUseMobileData @"prefs_use_mobile_data"
#define kPrefUserUseAttachWifi @"prefs_user_attach_wifi"

#define kPrefKeyHeaderOrientation @"prefs_header_orientation"
#define kPrefKeyHeaderOrientationPortrait @"prefs_header_orientation_portrait"
#define kPrefKeyHeaderOrientationLandscape @"prefs_header_orientation_landscape"

/*
 URLS
 */

//#define kUrlHost @"http://192.168.1.60/"

#define kUrlHost @"http://200.60.69.51"

#define kUrlApiHeaderAuthorization @"Authorization"
#define kUrlApiHeaderPrefix @"Bearer"

/******
 
 POST /SGSOnline/WebApi/Usuario/VerificarUsuario HTTP/1.1
 Host: 192.168.1.60
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6ImNkZTIyY2YwLTk3YzktNDViMi05OWY1LTVjZjk4MjE0ODY5YiIsImlhdCI6MTQ5MzI4NzU0NCwibmJmIjoxNDkzMjg3NTQ0LCJleHAiOjE0OTMyOTExNDQsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.cFvN5zXcQmWTgUlJGtYIP6wR_g11AC8DMPTBVNt0ecc
 Cache-Control: no-cache
 Postman-Token: a5157a13-0314-133f-04bc-62a7b1a86191
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idusuario"
 
 DHUAMAN
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 ******/

#define kUrlPathApiUser @"/SGSOnline/WebApi/Usuario/VerificarUsuario"
#define kUrlPathParamApiUser_idpais @"idpais"
#define kUrlPathParamApiUser_ididioma @"ididioma"
#define kUrlPathParamApiUser_idusuario @"idusuario"

#define kUrlPathApiUserResponseCodeSuccess @"0"

/*****
 
 POST /SGSOnline/WebApi/token HTTP/1.1
 Host: 200.60.69.51
 Content-Type: application/x-www-form-urlencoded
 Cache-Control: no-cache
 Postman-Token: 27a1e473-631e-5126-950c-8e211ff1ac4d
 
 username=novit&password=dhh_n0v1t_dhh
 
 POST /SGSOnline/WebApi/token HTTP/1.1
 Host: 192.168.1.60
 Content-Type: application/x-www-form-urlencoded
 Cache-Control: no-cache
 Postman-Token: 89ab21ad-be3b-ff5c-e9f8-35e4d3c71238
 
 username=novit&password=dhh_n0v1t_dhh
 *****/


#define kUrlPathApiToken @"/SGSOnline/WebApi/token"
#define kUrlPathParamApiToken_username @"username"
#define kUrlPathParamApiToken_username_value @"novit"

#define kUrlPathParamApiToken_pass @"password"
#define kUrlPathParamApiToken_pass_value @"dhh_n0v1t_dhh"

/*****
 GET /SGSOnline/WebApi/Idioma HTTP/1.1
 Host: 192.168.1.60
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6ImM1NDcyNzNjLTY5ZWItNGY5MC1hODg0LWUxNWEwYjJlOWM1YyIsImlhdCI6MTQ5MzIxMTc1MiwibmJmIjoxNDkzMjExNzUyLCJleHAiOjE0OTMyMTUzNTIsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.uexNC_bGlZDuaw67at0dhyWV8tkv7xkWVhslxvKZs3c
 Cache-Control: no-cache
 Postman-Token: ae7e3b81-75ac-b463-5401-9c2b484b0b1f
 *****/

#define kUrlPathApiIdiom @"/SGSOnline/WebApi/Idioma"

/*****
 POST /SGSOnline/WebApi/Pais HTTP/1.1
 Host: 192.168.1.60
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6ImM1NDcyNzNjLTY5ZWItNGY5MC1hODg0LWUxNWEwYjJlOWM1YyIsImlhdCI6MTQ5MzIxMTc1MiwibmJmIjoxNDkzMjExNzUyLCJleHAiOjE0OTMyMTUzNTIsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.uexNC_bGlZDuaw67at0dhyWV8tkv7xkWVhslxvKZs3c
 Cache-Control: no-cache
 Postman-Token: 38a9545b-ef06-992d-b55b-e2602dd88217
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 
 *****/

#define kUrlPathApiCountry @"/SGSOnline/WebApi/Pais"

#define kUrlPathParamApiCountry_ididioma @"ididioma"

/*****
 
 POST /SGSOnline/WebApi/Usuario/VerificarClave HTTP/1.1
 Host: 192.168.1.60
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6IjQ1ZTJmYjA2LWIzYzQtNDNmZC04MDRhLTI5YmNiYzEzZmQwYSIsImlhdCI6MTQ5MzI5MzM1NywibmJmIjoxNDkzMjkzMzU3LCJleHAiOjE0OTMyOTY5NTcsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.VAmGCWKavY0Pgy9WQXY3MVUJBRB0yjSdXdeOlOyo0h0
 Cache-Control: no-cache
 Postman-Token: d7c927d6-0ddd-789a-59a3-f97234af16df
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idusuario"
 
 DHUAMAN
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="clave"
 
 654321
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 
 *****/

#define kUrlPathApiUserPass @"/SGSOnline/WebApi/Usuario/VerificarClave"
#define kUrlPathParamApiUserPass_idpais @"idpais"
#define kUrlPathParamApiUserPass_ididioma @"ididioma"
#define kUrlPathParamApiUserPass_idusuario @"idusuario"
#define kUrlPathParamApiUserPass_clave @"clave"

#define kUrlPathApiUserPassResponseCodeSuccess @"0"

/*******

 POST /SGSOnline/WebApi/TerminosCondiciones/ListarTerminos HTTP/1.1
 Host: 192.168.1.60
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6IjQ1ZTJmYjA2LWIzYzQtNDNmZC04MDRhLTI5YmNiYzEzZmQwYSIsImlhdCI6MTQ5MzI5MzM1NywibmJmIjoxNDkzMjkzMzU3LCJleHAiOjE0OTMyOTY5NTcsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.VAmGCWKavY0Pgy9WQXY3MVUJBRB0yjSdXdeOlOyo0h0
 Cache-Control: no-cache
 Postman-Token: 2cc183fa-f94d-42e6-7244-e311cd337111
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idusuario"
 
 DHUAMAN
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 
 ******/

#define kUrlPathApiListTerms @"/SGSOnline/WebApi/TerminosCondiciones/ListarTerminos"
#define kUrlPathParamApiListTerms_idpais @"idpais"
#define kUrlPathParamApiListTerms_ididioma @"ididioma"
#define kUrlPathParamApiListTerms_idusuario @"idusuario"

/*******
 
 POST /SGSOnline/WebApi/TerminosCondiciones/AceptarTerminos HTTP/1.1
 Host: 192.168.1.60
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6IjQ1ZTJmYjA2LWIzYzQtNDNmZC04MDRhLTI5YmNiYzEzZmQwYSIsImlhdCI6MTQ5MzI5MzM1NywibmJmIjoxNDkzMjkzMzU3LCJleHAiOjE0OTMyOTY5NTcsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.VAmGCWKavY0Pgy9WQXY3MVUJBRB0yjSdXdeOlOyo0h0
 Cache-Control: no-cache
 Postman-Token: d9d08afe-572f-5541-424f-a0a3ca34021e
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idusuario"
 
 DHUAMAN
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 
 *******/

#define kUrlPathApiAcceptTerms @"/SGSOnline/WebApi/TerminosCondiciones/AceptarTerminos"
#define kUrlPathParamApiAcceptTerms_idpais @"idpais"
#define kUrlPathParamApiAcceptTerms_idusuario @"idusuario"

/*****
 
 POST /SGSOnline/WebApi/Menu HTTP/1.1
 Host: 192.168.1.60
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6ImMzYWQxZjBjLTY3MjQtNDJjNi1hOTYzLWZkZDEyODlmMjQxYiIsImlhdCI6MTQ5MzMwMjY2OCwibmJmIjoxNDkzMzAyNjY4LCJleHAiOjE0OTMzMDYyNjgsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.w4ozW8ZPnnDsTdp7klLIAr9tdVPK61WIwXaJEsdwVuQ
 Content-Type: application/x-www-form-urlencoded
 Cache-Control: no-cache
 Postman-Token: c8fc211e-093a-ec7a-104d-1e091d556dcc
 
 idpais=PE&ididioma=ES&idusuario=DHUAMAN
 
 ****/

#define kUrlPathApiMenu @"/SGSOnline/WebApi/Menu"
#define kUrlPathParamApiMenu_idpais @"idpais"
#define kUrlPathParamApiMenu_ididioma @"ididioma"
#define kUrlPathParamApiMenu_idusuario @"idusuario"

/*****
 
 POST /SGSOnline/WebApi/MenuListado HTTP/1.1
 Host: 200.60.69.51
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6IjNiNTA3ZTcwLWI5YWMtNDliMy05ZmM2LWMxZmQ1MDVmMmYyYiIsImlhdCI6MTQ5NTczODM2NSwibmJmIjoxNDk1NzM4MzY1LCJleHAiOjE0OTU3NDE5NjUsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.KNaBI9oEIq_megav56RNiKdE3hZJZ8C-i5ZV9NpIbBs
 Cache-Control: no-cache
 Postman-Token: fbb8790b-48e8-ee6b-d166-f4c4da8b6e4b
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idusuario"
 
 danielhuaman@outlook.coms
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idmenu"
 
 M2017SGS00001
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="valorbusqueda"
 
 wewer
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="pagina"
 
 1
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="boolimportante"
 
 true
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 
 *****/

#define kUrlPathApiMenuDetail @"/SGSOnline/WebApi/MenuListado"
#define kUrlPathParamApiMenuDetail_idpais @"idpais"
#define kUrlPathParamApiMenuDetail_ididioma @"ididioma"
#define kUrlPathParamApiMenuDetail_idusuario @"idusuario"
#define kUrlPathParamApiMenuDetail_idmenu @"idmenu"
#define kUrlPathParamApiMenuDetail_valorbusqueda @"valorbusqueda"
#define kUrlPathParamApiMenuDetail_boolimportante @"boolimportante"
#define kUrlPathParamApiMenuDetail_pagina @"pagina"

/********
 
 POST /SGSOnline/WebApi/Parametros/ListarParametros HTTP/1.1
 Host: 200.60.69.51
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6ImZmMjY5NWYxLTAxNTYtNDViMC1hZWY0LTYzMmMzNTcyYmM2YyIsImlhdCI6MTQ5NDAxMDQ5MSwibmJmIjoxNDk0MDEwNDkxLCJleHAiOjE0OTQwMTQwOTEsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.OaHG5bUDs7JkYKvUuqXJFJrlKEt5eAVYIIM8--jOreI
 Cache-Control: no-cache
 Postman-Token: 1596b773-b24b-d742-8ec4-3cd0e98f15b6
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idusuario"
 
 DHUAMAN
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idparametro"
 
 4
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 
 ********/

#define kUrlPathApiParams @"/SGSOnline/WebApi/Parametros/ListarParametros"
#define kUrlPathParamApiParams_idpais @"idpais"
#define kUrlPathParamApiParams_ididioma @"ididioma"
#define kUrlPathParamApiParams_idusuario @"idusuario"
#define kUrlPathParamApiParams_idparametro @"idparametro"

/****
 
 POST /SGSOnline/WebApi/Parametros/ActualizarSeleccion HTTP/1.1
 Host: 200.60.69.51
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6IjJkMTA3MWIyLTRjMTItNDU2Ny1iMzY3LWU2ZjI5YzU5M2U1ZCIsImlhdCI6MTQ5NDAyNTg1MywibmJmIjoxNDk0MDI1ODUzLCJleHAiOjE0OTQwMjk0NTMsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.4KqeQiIpJFpD3RH-cgc5i3qBIhKkqYQANo4U3zAE5cc
 Cache-Control: no-cache
 Postman-Token: 89580ea7-68c4-c3d1-d1c5-194d7c20fba9
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idusuario"
 
 DHUAMAN
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idparametro"
 
 4
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idparametrodetalle"
 
 13
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 
 ****/

#define kUrlPathApiParamsUpdate @"/SGSOnline/WebApi/Parametros/ActualizarSeleccion"
#define kUrlPathParamApiParamsUpdate_idpais @"idpais"
#define kUrlPathParamApiParamsUpdate_idusuario @"idusuario"
#define kUrlPathParamApiParamsUpdate_idparametro @"idparametro"
#define kUrlPathParamApiParamsUpdate_idparametrodetalle @"idparametrodetalle"

/****
 
 POST /SGSOnline/WebApi/RedSocial HTTP/1.1
 Host: 200.60.69.51
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6IjU1YTdkMjMzLTg4NTctNDA1Ny1iNjA3LWY5ZTk4NDM5ZmZjMyIsImlhdCI6MTQ5NDI3ODUxNiwibmJmIjoxNDk0Mjc4NTE2LCJleHAiOjE0OTQyODIxMTYsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.0SuHhf_f-Th0gg6teuIfTW6hdnKIIiVT25Q1DExC29Y
 Cache-Control: no-cache
 Postman-Token: ea11753c-261e-d90c-9f29-3b857b4c7674
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 
 ****/

#define kUrlPathApiSocial @"/SGSOnline/WebApi/RedSocial"
#define kUrlPathParamApiSocial_idpais @"idpais"
#define kUrlPathParamApiSocial_ididioma @"ididioma"

/**
 POST /SGSOnline/WebApi/Oficina HTTP/1.1
 Host: 200.60.69.51
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6IjMxZjQ3YjY2LTljMTQtNDZhMi05Zjg0LTAwMWM1YzdiNTI3ZSIsImlhdCI6MTQ5NDM1MDMwOSwibmJmIjoxNDk0MzUwMzA5LCJleHAiOjE0OTQzNTM5MDksImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.qASjudGNV66tbqVnQYWx23rswMmXjmrPoilAV7J1lH0
 Cache-Control: no-cache
 Postman-Token: af41b30a-3825-062b-91c3-0aba2c458e38
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 **/

#define kUrlPathApiOffice @"/SGSOnline/WebApi/Oficina"
#define kUrlPathParamApiOffice_idpais @"idpais"
#define kUrlPathParamApiOffice_ididioma @"ididioma"

/***
 POST /SGSOnline/WebApi/MenuListadoDetalle HTTP/1.1
 Host: 200.60.69.51
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6ImNhZTJkM2U0LThlNGMtNDJhNC1iOTFhLTg3MDQ5MzQzYTYwMSIsImlhdCI6MTQ5NDUxNTQ5OCwibmJmIjoxNDk0NTE1NDk4LCJleHAiOjE0OTQ1MTkwOTgsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.7b43g29xJh--zOAcVVS3g5bjRFx4mC5rnPK_Yy2KeQA
 Cache-Control: no-cache
 Postman-Token: c64dea22-ed87-38bf-b88a-f0bd39f2d4e5
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idusuario"
 
 DHUAMAN
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idmenu"
 
 M2017SGS00001
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idmenudetalle"
 
 null
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 ****/

#define kUrlPathApiMenuDetailInfo @"/SGSOnline/WebApi/MenuListadoDetalle"
#define kUrlPathParamMenuDetailInfo_idpais @"idpais"
#define kUrlPathParamMenuDetailInfo_ididioma @"ididioma"
#define kUrlPathParamMenuDetailInfo_idusuario @"idusuario"
#define kUrlPathParamMenuDetailInfo_idmenu @"idmenu"
#define kUrlPathParamMenuDetailInfo_idmenudetalle @"idmenudetalle"

/**
 POST /SGSOnline/WebApi/PerfilUsuario HTTP/1.1
 Host: 200.60.69.51
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6IjcyMGJmNzZiLWJkZmQtNDNhZi1hZjk4LWFmNjExNWJlYjNmNSIsImlhdCI6MTQ5NDk3MzA0OSwibmJmIjoxNDk0OTczMDQ5LCJleHAiOjE0OTQ5NzY2NDksImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.pwqZ7xX0LmEgV7gHfnTMR-BUS-vY0M6-XXp1ZO0piLI
 Cache-Control: no-cache
 Postman-Token: dcfeffd8-a553-3642-6bdb-62c167e5ea00
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idusuario"
 
 Rone Lozahuaman@outlook.com
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 **/

#define kUrlPathApiUserProfile @"/SGSOnline/WebApi/PerfilUsuario"
#define kUrlPathParamUserProfile_idpais @"idpais"
#define kUrlPathParamUserProfile_ididioma @"ididioma"
#define kUrlPathParamUserProfile_idusuario @"idusuario"

/***

 POST /SGSOnline/WebApi/MenuListadoAdjunto/ListarAdjuntos HTTP/1.1
 Host: 200.60.69.51
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6ImIwODg0YjJiLTdkZTMtNDM3Mi1iMzQ5LWI1YTg5YmEwYTBiNSIsImlhdCI6MTQ5NTA0MTc2OSwibmJmIjoxNDk1MDQxNzY5LCJleHAiOjE0OTUwNDUzNjksImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.YsGGlfd3MNtWXykDWfObMrkqcwyND73t-MOkjNianOg
 Cache-Control: no-cache
 Postman-Token: b3f43ed0-d478-3e1b-ba23-cfc652a5842e
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idusuario"
 
 Rone Lozahuaman@outlook.com
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idmenu"
 
 M2017SGS00001
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idmenudetalle"
 
 MD2017SGS00001
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 
 **/

#define kUrlPathApiListAttach @"/SGSOnline/WebApi/MenuListadoAdjunto/ListarAdjuntos"
#define kUrlPathParamListAttach_idpais @"idpais"
#define kUrlPathParamListAttach_ididioma @"ididioma"
#define kUrlPathParamListAttach_idusuario @"idusuario"
#define kUrlPathParamListAttach_idmenu @"idmenu"
#define kUrlPathParamListAttach_idmenudetalle @"idmenudetalle"

/*
 
 POST /SGSOnline/WebApi/MenuListadoAdjunto/ObtenerAdjunto HTTP/1.1
 Host: 200.60.69.51
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6ImIxYTI1OGNiLTM2ZjEtNGUwYS1hNTFlLWVhNWM5OTMzNmE0OCIsImlhdCI6MTQ5NTIzMDI5MCwibmJmIjoxNDk1MjMwMjkwLCJleHAiOjE0OTUyMzM4OTAsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.Rm6enA0_0U9toqZKiL_fXT0R6yHnJPGb7j3HxTqysIU
 Cache-Control: no-cache
 Postman-Token: 17650ae6-c0df-c752-ef4c-2adb5390abe5
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idusuario"
 
 Rone Lozahuaman@outlook.com
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idmenu"
 
 M2017SGS00001
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idmenudetalle"
 
 MD2017SGS00001
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idadjunto"
 
 MDA2017SGS00007
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 */

#define kUrlPathApiAttach @"/SGSOnline/WebApi/MenuListadoAdjunto/ObtenerAdjunto"
#define kUrlPathParamAttach_idpais @"idpais"
#define kUrlPathParamAttach_ididioma @"ididioma"
#define kUrlPathParamAttach_idusuario @"idusuario"
#define kUrlPathParamAttach_idmenu @"idmenu"
#define kUrlPathParamAttach_idmenudetalle @"idmenudetalle"
#define kUrlPathParamAttach_idadjunto @"idadjunto"

/*
 
 POST /SGSOnline/WebApi/Directorio HTTP/1.1
 Host: 200.60.69.51
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6ImM2MWQ2MjRiLTZjMGUtNDNkOS1iYWEwLTVlNWE5NWZkYWZiNSIsImlhdCI6MTQ5NjI1ODkxMiwibmJmIjoxNDk2MjU4OTEyLCJleHAiOjE0OTYyNjI1MTIsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.FCO1TNczQxScdT4fDep_Cjpj6r3nwFMxBPIbzjq2qcU
 Cache-Control: no-cache
 Postman-Token: b7086ae4-c05e-8051-383e-7248741baec3
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 
 */

#define kUrlPathApiDirectory @"/SGSOnline/WebApi/Directorio"
#define kUrlPathParamDirectory_idpais @"idpais"
#define kUrlPathParamDirectory_ididioma @"ididioma"

/*
 POST /SGSOnline/WebApi/Notificacion HTTP/1.1
 Host: 200.60.69.51
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6IjNlNzA0NGZmLTViOTQtNGU2Yi04NGYwLTMzNzUyZjUzYjRkMiIsImlhdCI6MTQ5NjMzNjk3NSwibmJmIjoxNDk2MzM2OTc1LCJleHAiOjE0OTYzNDA1NzUsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.4PKonwJD96xTastcYLrClDC6sq-dNPAR6tRBWxuC3xw
 Cache-Control: no-cache
 Postman-Token: ee935060-9cd7-b3be-bfec-6c5b53595af7
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idusuario"
 
 danielhuaman@outlook.com
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="boolimportante"
 
 true
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="valorbusqueda"
 
 null
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="pagina"
 
 1
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 */

#define kUrlPathApiNotification @"/SGSOnline/WebApi/Notificacion"
#define kUrlPathParamNotification_idpais @"idpais"
#define kUrlPathParamNotification_ididioma @"ididioma"
#define kUrlPathParamNotification_idusuario @"idusuario"
#define kUrlPathParamNotification_boolimportante @"boolimportante"
#define kUrlPathParamNotification_valorbusqueda @"valorbusqueda"
#define kUrlPathParamNotification_pagina @"pagina"

/*
 
 POST /SGSOnline/WebApi/ContadorNotificacion/TotalNoLeidos HTTP/1.1
 Host: 200.60.69.51
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6Ijc4YTMzOTQ0LTNlNDYtNGExNi05N2YyLWNiNTQxMTUzMGVhNSIsImlhdCI6MTQ5NjM1MjczOCwibmJmIjoxNDk2MzUyNzM4LCJleHAiOjE0OTYzNTYzMzgsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.5T5wIvNB69cCMIHZ1x_8TUEqaFjRj5Kk5t1igOl_170
 Cache-Control: no-cache
 Postman-Token: 32799bd2-e4fe-f2cb-59fb-b28a1059a710
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idusuario"
 
 DHUAMAN
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 
 */

#define kUrlPathApiNotiUnread @"/SGSOnline/WebApi/ContadorNotificacion/TotalNoLeidos"
#define kUrlPathParamNotiUnread_idpais @"idpais"
#define kUrlPathParamNotiUnread_ididioma @"ididioma"
#define kUrlPathParamNotiUnread_idusuario @"idusuario"

/*
 
 POST /SGSOnline/WebApi/Estado/ActualizarLecturaNotificacion HTTP/1.1
 Host: 200.60.69.51
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6IjdjYzE2MGMxLWE3MjItNGJmNC05MGVkLTY4NDM0YzNmZjBlMSIsImlhdCI6MTQ5NTcyODc4OCwibmJmIjoxNDk1NzI4Nzg4LCJleHAiOjE0OTU3MzIzODgsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.mltlv4ajOh9HThg80Ywe4FfaVbR4fK9uQ2OfzZdCTrs
 Cache-Control: no-cache
 Postman-Token: ccad6320-7a9a-8a8b-f3cd-eb830d276900
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idusuario"
 
 danielhuaman@outlook.com
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idnotificacion"
 
 NOTSGS201700001
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 
 */

#define kUrlPathApiNotiUpdateRead @"/SGSOnline/WebApi/Estado/ActualizarLecturaNotificacion"
#define kUrlPathParamNotiUpdateRead_idpais @"idpais"
#define kUrlPathParamNotiUpdateRead_ididioma @"ididioma"
#define kUrlPathParamNotiUpdateRead_idusuario @"idusuario"
#define kUrlPathParamNotiUpdateRead_idnotificacion @"idnotificacion"

/*
 
 POST /SGSOnline/WebApi/NotificacionDetalle HTTP/1.1
 Host: 200.60.69.51
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6IjMyNGQ4OTAwLTQ1MDctNDJiOS1hZTZmLWQ2MDM2OGZkZTcyMSIsImlhdCI6MTQ5NjM2MTg3NiwibmJmIjoxNDk2MzYxODc2LCJleHAiOjE0OTYzNjU0NzYsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.Gl10yhTHCFa1spTieigFQ0h8LeNjrXGJWsmmueb5VnE
 Cache-Control: no-cache
 Postman-Token: 39c52b78-eb53-51b3-8ce0-2753ab31a1ac
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idusuario"
 
 danielhuaman@outlook.com
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idnotificacion"
 
 NOTSGS201700001
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 
 */

#define kUrlPathApiNotiDetail @"/SGSOnline/WebApi/NotificacionDetalle"
#define kUrlPathParamNotiDetail_idpais @"idpais"
#define kUrlPathParamNotiDetail_ididioma @"ididioma"
#define kUrlPathParamNotiDetail_idusuario @"idusuario"
#define kUrlPathParamNotiDetail_idnotificacion @"idnotificacion"

/*
 
 POST /SGSOnline/WebApi/NotificacionAdjunto/ListarAdjuntos HTTP/1.1
 Host: 200.60.69.51
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6IjdhNGJkZGJmLTFlN2YtNDEwMy1hZWMwLTI5ZTc0NTcwODg4NCIsImlhdCI6MTQ5NjQxODQxMywibmJmIjoxNDk2NDE4NDEzLCJleHAiOjE0OTY0MjIwMTMsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.AukXMPynrJqcSCBVIJPT4BgdVWo2gJLFRZfxgLnYWF8
 Cache-Control: no-cache
 Postman-Token: ffb7e3eb-2a22-fca1-f56e-d353378fe30f
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idusuario"
 
 danielhuaman@outlook.com
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idnotificacion"
 
 M2017SGS00001
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 
 */

#define kUrlPathApiNotiListAttach @"/SGSOnline/WebApi/NotificacionAdjunto/ListarAdjuntos"
#define kUrlPathParamNotiListAttach_idpais @"idpais"
#define kUrlPathParamNotiListAttach_ididioma @"ididioma"
#define kUrlPathParamNotiListAttach_idusuario @"idusuario"
#define kUrlPathParamNotiListAttach_idnotificacion @"idnotificacion"

/*
 POST /SGSOnline/WebApi/NotificacionAdjunto/ObtenerAdjunto HTTP/1.1
 Host: 200.60.69.51
 Authorization: Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJzdWIiOiJub3ZpdCIsImp0aSI6IjdhNGJkZGJmLTFlN2YtNDEwMy1hZWMwLTI5ZTc0NTcwODg4NCIsImlhdCI6MTQ5NjQxODQxMywibmJmIjoxNDk2NDE4NDEzLCJleHAiOjE0OTY0MjIwMTMsImlzcyI6IkV4YW1wbGVJc3N1ZXIiLCJhdWQiOiJFeGFtcGxlQXVkaWVuY2UifQ.AukXMPynrJqcSCBVIJPT4BgdVWo2gJLFRZfxgLnYWF8
 Cache-Control: no-cache
 Postman-Token: f5f78a4d-7a73-9dc7-c150-f5531ca40976
 Content-Type: multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW
 
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idpais"
 
 PE
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="ididioma"
 
 ES
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idusuario"
 
 danielhuaman@outlook.com
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idnotificacion"
 
 M2017SGS00001
 ------WebKitFormBoundary7MA4YWxkTrZu0gW
 Content-Disposition: form-data; name="idadjunto"
 
 MDA2017SGS00003
 ------WebKitFormBoundary7MA4YWxkTrZu0gW--
 */

#define kUrlPathApiNotiAttach @"/SGSOnline/WebApi/NotificacionAdjunto/ObtenerAdjunto"
#define kUrlPathParamNotiAttach_idpais @"idpais"
#define kUrlPathParamNotiAttach_ididioma @"ididioma"
#define kUrlPathParamNotiAttach_idusuario @"idusuario"
#define kUrlPathParamNotiAttach_idnotificacion @"idnotificacion"
#define kUrlPathParamNotiAttach_idadjunto @"idadjunto"

/**
 Colors RGB
 **/

//#define kColorSGS 0xFF7C00
#define kColorSGS 0xFC6621
#define kColorWhite 0xFFFFFF
#define kColorWhiteOdd 0xF6F6F6
#define kColorLightGrey 0xAAAAAA
#define kColorCellDetail 0xF6F6F6

#define kColorGrey 0xF6F6F6

/** ENUMS **/

typedef CF_ENUM(int, CustomNetworkErrors) {
    
    kErrorNotUnvailableWWANConnectedToInternet = 1
};

const static NSErrorDomain kCustomNetworkErrors = @"com.novit.CustomErrors";

/** Functions **/

#define UIColorFromHex(hex, opacity) [UIColor colorWithRed:((float)((hex & 0xFF0000) >> 16))/255.0 green:((float)((hex & 0xFF00) >> 8))/255.0 blue:((float)(hex & 0xFF))/255.0 alpha:opacity]

#define BETWEEN(value, min, max) (value < max && value > min)

#define AppDebugECLog(s,...) NSLog(s, ##__VA_ARGS__)
//#define AppDebugECLog(s,...)


#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

static inline BOOL isSystemVersionGreatherThanOrEqaulTo(NSString *v) {
    
    return ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending);
}

static inline id UIStoryboardInstantiateViewControllerWithIdentifier(NSString *storyboarName, NSString *identifier)
{
    
    return [[UIStoryboard storyboardWithName:storyboarName bundle:nil] instantiateViewControllerWithIdentifier:identifier];
}
