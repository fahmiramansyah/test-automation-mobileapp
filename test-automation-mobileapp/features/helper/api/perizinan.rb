def notAllowPerizinan
    if page.has_xpath?('//android.view.View[@content-desc="Perizinan Jamtangan.com
mengakses data Anda"]')
    find(:xpath, '//android.widget.Button[@content-desc="TIDAK SETUJU"]').click
    end
end

def closePopupMoe
    if page.has_xpath?('/hierarchy/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.ImageView')
    find(:xpath, '/hierarchy/android.widget.FrameLayout/android.widget.RelativeLayout/android.widget.ImageView').click
    end
end