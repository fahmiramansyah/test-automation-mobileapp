# Skeleton Mobile App Automaiton Test
Software Automation Testing Android & iOS using Appium, ruby, capybara, and cucumber

## How to Setup (Mac)
1. make sure you are already setup automation website

2. Install [Xcode](https://apps.apple.com/us/app/xcode/id497799835?mt=12)

3. Install [Android_studio] (https://developer.android.com/studio?gclid=CjwKCAiA9qKbBhAzEiwAS4yeDQbjbqM8ZI10d-jrN9bm3D86z8Kl58kJ8JxqciDcjosKhyvhIoUvwxoCxWkQAvD_BwE&gclsrc=aw.ds)

4. Install [Appium] (https://github.com/appium/appium-desktop/releases)
    choose file .dmg

5. Install [Appium_Inspector] (https://github.com/appium/appium-inspector/releases)
    choose file .dmg

6. Set Android Home & Android SDK :
  -  open .bash_profile / .zshrc on terminal
  input :
  - export ANDROID_HOME="Users/"your_name"/Library/Android/sdk"
  - export PATH="${PATH}:/$ANDROID_HOME/platform-tools:/$ANDROID_HOME/tools:/$ANDROID_HOME/tools/bin 
  then save   

7. Install Appium Lib & Cucumber
  —> sudo gem install cucumber
  —> sudo gem install appium_lib

8. Setup Gem

  ```
    rvm use 2.6.3@web-test --create
    gem install bundler
    bundle install
  ```

9. Launch appium & simulator device from xcode/android studio 
    image.png

    simulator android studio = open android studio > avd manager > choose device > play
    simulator xcode = open xcode > XCode > Open Developer Tool > Simulator 

    setup on env.rb ( make sure same as your device )
    image.png

10. Run the Test

  ```
    cucumber TARGET=dev --tags @login
    OR
    cucumber TARGET=dev -t @login -t @desktop --retry 3 --no-strict-flaky -f rerun --out rerun.txt
  ```
