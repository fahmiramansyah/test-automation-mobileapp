require_relative '../pages/base_page'    
class HomePageAndroid < SitePrism::Page

  include BasePage

# #object repository
# colornote
element :lblColorNote, :xpath, '/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.LinearLayout/android.widget.TextView'
element :lblPrivacyPolicy, :id, "com.socialnmobile.dictapps.notepad.color.note:id/privacy_policy"
element :btnNextBeginningScreen, :id, "com.socialnmobile.dictapps.notepad.color.note:id/step1_next"
element :lblPermissionRequest, :xpath, "/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.TextView[1]"
element :descPermissionRequest, :id, "com.socialnmobile.dictapps.notepad.color.note:id/step3description"
element :btnNextPermissionReq, :id, "com.socialnmobile.dictapps.notepad.color.note:id/step3_next"
element :btnAllowPermissionReq, :id, "com.android.permissioncontroller:id/permission_allow_button"
element :lblWelcomeToColorNote, :xpath, "/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.RelativeLayout/android.widget.TextView[1]"
element :lblEasytoFollow, :xpath, "/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.RelativeLayout/android.widget.TextView[2]"
element :btnSkipTutorial, :id, "com.socialnmobile.dictapps.notepad.color.note:id/btn_start_skip"
element :btnStartTutorial, :id, "com.socialnmobile.dictapps.notepad.color.note:id/btn_start"
# home
element :logoHomeColornote, :id, "com.socialnmobile.dictapps.notepad.color.note:id/main_logo"
element :lblAddNote, :id, "com.socialnmobile.dictapps.notepad.color.note:id/img_add"
element :btnPlusAddNote, :id, "com.socialnmobile.dictapps.notepad.color.note:id/bottom_fab"
element :iconCalendar, :xpath, '//android.widget.FrameLayout[@content-desc="Calendar"]/android.widget.ImageView'
element :iconSearch, :xpath, '//android.widget.FrameLayout[@content-desc="Search"]/android.widget.ImageView'
element :clickText, :xpath, '/hierarchy/android.widget.FrameLayout/android.widget.LinearLayout/android.widget.FrameLayout/android.widget.FrameLayout/android.widget.FrameLayout/androidx.appcompat.widget.LinearLayoutCompat/android.widget.FrameLayout/android.widget.ListView/android.widget.LinearLayout[1]'
element :usrInputNotes, :id, 'com.socialnmobile.dictapps.notepad.color.note:id/edit_note'

def validateSplashScreen
    # allowNotificationBeginningScreen.should be_visible
    # allowNotificationBeginningScreen.click
    splashScreen.should be_visible
end

def validateBeginningScreen
  lblColorNote.should be_visible
  lblPrivacyPolicy.should be_visible
  btnNextBeginningScreen.should be_visible
end

def clickNextBeginningScreen
  btnNextBeginningScreen.click
end

def validatePermissionReq
  lblPermissionRequest.should be_visible
  descPermissionRequest.should be_visible
  btnNextPermissionReq.should be_visible
end

def clickNextPermissionReq
  btnNextPermissionReq.click
end

def clickAllowPermissionReq
  btnAllowPermissionReq.click
end

def validateTutorialFeature
  lblWelcomeToColorNote.should be_visible
  lblEasytoFollow.should be_visible
  btnSkipTutorial.should be_visible
  btnStartTutorial.should be_visible
end

def clickSkipTutorial
  btnSkipTutorial.click
end

def validateHomeColornote
  logoHomeColornote.should be_visible
  lblAddNote.should be_visible
  btnPlusAddNote.should be_visible
  iconCalendar.should be_visible
  iconSearch.should be_visible
end

def clickAddNote
  lblAddNote.click
  clickText.click
end

def inputNotes(notes)
  usrInputNotes.set(notes)
end

end
