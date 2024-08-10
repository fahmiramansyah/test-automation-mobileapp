def swipeFlashSaleSec
    if page.has_xpath?('//android.widget.Button[@content-desc="LIHAT SEMUA"]')
        swipe(300,700,300,0)
    end
end