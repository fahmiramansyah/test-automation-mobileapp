  def get_current_context
    current_context = $capy_driver.appium_driver.current_context
    return current_context
  end
  
  # def swipe(x1,y1,x2,y2,duration = 1000)
    # $capy_driver.swipe(:start_x => x1, :start_y => y1, :end_x => x2, :end_y => y2, :duration => duration)

  # end
  
  # scroll from screen with
  # - :xpath
  # - :class
  # - :id
  def swipe_by_screen_size(find_by, element, direction = "up", duration = 1000, num = 30)
    w_s = get_window_size
    x1 = 0
    x2 = 0
    y1 = 0
    y2 = 0
  
    (1..num).each do |_count|
      case direction
      when "up"
        y1 = w_s.height * 0.42
        y2 = w_s.height * 0.10
        x1 = w_s.width / 2
      when "down"
        x1 = w_s.width / 2
        y1 = w_s.height * 0.30
        y2 = w_s.height * 0.70
      when "right"
        x1 = w_s.width * 0.05
        x2 = w_s.width * 0.90
        y1 = w_s.height / 2
      else
        y1 = w_s.height / 2
        x2 = w_s.width * 0.05
        x1 = w_s.width * 0.90
      end
      begin
        sleep 2
        $capy_driver.appium_driver.find_element(find_by, element).displayed?
        element_visible = true
        puts element_visible
      rescue
        element_visible = false
        puts element_visible
      end
      if element_visible.eql? true
        break
      else
        swipe(x1,y1,x2,y2,duration)
      end
      if _count.eql? num
        raise "Element #{element} tidak ditemukan"
      end
    end
  end

  def swipe_by_screen_size_ios(find_by, element, direction = "up", duration = 3000, num = 30)
    w_s = get_window_size
    x1 = 0
    x2 = 0
    y1 = 0
    y2 = 0
  
    (1..num).each do |_count|
      case direction
      when "up"
        y1 = w_s.height * 0.40
        y2 = w_s.height * 0.10
        x1 = w_s.width / 2
      when "down"
        x1 = w_s.width / 2
        y1 = w_s.height * 0.10
        y2 = w_s.height * 0.40
      when "right"
        x1 = w_s.width * 0.05
        x2 = w_s.width * 0.90
        y1 = w_s.height / 2
      else
        y1 = w_s.height / 2
        x2 = w_s.width * 0.05
        x1 = w_s.width * 0.90
      end
      begin
        sleep 2
        $capy_driver.appium_driver.find_element(find_by, element).displayed?
        element_visible = true
        puts element_visible
      rescue
        element_visible = false
        puts element_visible
      end
      if element_visible.eql? true
        break
      else
        swipe_ios(x1,y1,x2,y2,duration)
      end
      if _count.eql? num
        raise "Element #{element} tidak ditemukan"
      end
    end
  end







  # def swipe_to_element(find_by, element)
  #   swipe(100,500,100,0)
  #   sleep 1
  #   if $capy_driver.appium_driver.find_element(find_by, element).displayed?
  #     element_visible = true
  #   else
  #     element_visible = false  
  #   end
  #   if element_visible.eql? true
  #     puts element_visible
  #   else
  #     puts element_visible
  #     swipe(100,500,100,0)
  #   end
  # end 

  
  def swipe_left(loop)
    loop.times do
      anchor =$capy_driver.appium_driver.window_size.height/2
      start =$capy_driver.appium_driver.window_size.width * 0.70
      end_point =$capy_driver.appium_driver.window_size.width * 0.30
  
      $capy_driver.swipe(start_x: end_point, start_y: anchor, end_x: start, end_y: anchor, duration: 250)
    end
  end
  
  def swipe_down(loop=1)
    loop.times do
      anchor =$capy_driver.appium_driver.window_size.width / 2
      start =$capy_driver.appium_driver.window_size.height * 0.4
      end_point =$capy_driver.appium_driver.window_size.height * 0.6
      $capy_driver.swipe(start_x: anchor, start_y: start, end_x: 0, end_y: end_point, duration: 250)
    end
  end
  
  def swipe_up(loop=1)
    loop.times do
      anchor =$capy_driver.appium_driver.window_size.width/2
      start =$capy_driver.appium_driver.window_size.height * 0.6
      end_point =$capy_driver.appium_driver.window_size.height * 0.4
  
      $capy_driver.swipe(start_x: anchor, start_y: start, end_x: anchor, end_y: end_point, duration: 250)
      sleep 2
    end
  end
  
  def get_window_size
    window_size = $capy_driver.appium_driver.window_size
    return window_size
  end
  
  def switch_webview_to_native
    native = $capy_driver.appium_driver.available_contexts.first
    $capy_driver.appium_driver.set_context(native)
  end
  
  # :class, :class_name, :css, :id, :link, :link_text, :name, :partial_link_text, :relative, :tag_name, :xpath, :accessibility_id, :image, :custom, :uiautomator, :viewtag, :data_matcher, :view_matcher, :uiautomation, :predicate, :class_chain, :windows_uiautomation, :tizen_uiautomation
  def find_element_apps_by(locator_strategy, value)
    $capy_driver.appium_driver.find_element(locator_strategy, "#{value}")
  end
  
  # :class, :class_name, :css, :id, :link, :link_text, :name, :partial_link_text, :relative, :tag_name, :xpath, :accessibility_id, :image, :custom, :uiautomator, :viewtag, :data_matcher, :view_matcher, :uiautomation, :predicate, :class_chain, :windows_uiautomation, :tizen_uiautomation
  def find_elements_apps_by(locator_strategy, value)
    $capy_driver.appium_driver.find_elements(locator_strategy, "#{value}")
  end
  
  # :class, :class_name, :css, :id, :link, :link_text, :name, :partial_link_text, :relative, :tag_name, :xpath, :accessibility_id, :image, :custom, :uiautomator, :viewtag, :data_matcher, :view_matcher, :uiautomation, :predicate, :class_chain, :windows_uiautomation, :tizen_uiautomation
  def has_element_apps_visible?(locator_strategy, value, wait = 5)
    begin
      wait_for(wait) { find_element_apps_by(locator_strategy, "#{value}").displayed? }
      true
    rescue
      false
    end
  end
  
  def expect_apps_have_text(text, wait = 10)
    raise "Label or Text with contains '#{text}' not found" unless has_element_apps_visible?(:xpath, "//*[contains(@text,'#{text}') or contains(@label,'#{text}') or contains(@value,'#{text}')]", wait) == true
  end

  # def swipe_to_element(value)
  #   3.times { Appium::TouchAction.new($capy_driver.appium_driver).swipe(start_x: 75, start_y: 500, offset_x: 75, offset_y: 20, duration: 500).perform }

  #   until exists{ value }do
  #     puts "lalala"
  #     Appium::TouchAction.new($capy_driver.appium_driver).swipe(start_x: 75, start_y: 500, offset_x: 75, offset_y: 20, duration: 500)
  #   end

  #   value.should be_visible
  # end  


  def swipe(x1, y1, x2, y2, duration = 1000)
    action = Appium::TouchAction.new($capy_driver.appium_driver)
    action.press(x: x1, y: y1)
          .wait(duration)
          .move_to(x: x2, y: y2)
          .release
          .perform
  end

  def swipe_ios(x1, y1, x2, y2, duration = 3000)
    action = Appium::TouchAction.new($capy_driver.appium_driver)
    action.press(x: x1, y: y1)
          .wait(duration)
          .move_to(x: x2, y: y2)
          .release
          .perform
  end

  def switch_native_to_webview_android
    webview_android = "WEBVIEW_#{$get_android_package_name}"
    if $capy_driver.appium_driver.available_contexts.include? webview_android
      webview = webview_android
    else
      webview = "WEBVIEW_chrome"
    end
    $capy_driver.appium_driver.set_context(webview)
    sleep 2
    get_url = page.current_url
    unless get_url.include? "http"
      get_window = $capy_driver.appium_driver.window_handles
      (0..5).each do |count|
        $capy_driver.appium_driver.switch_to.window(get_window[count])
        get_url_after_switch = page.current_url
        break unless get_url_after_switch.eql? "about:blank"
      end
    end
  end