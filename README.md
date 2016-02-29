README

* Ruby version 2.2.3
* Rails version 4.2

To run application you need:
* Clone project into your PC
* Go to holder *./hardlib
* Change database.yml like database.yml.example
* bundle install
* rake db:create db:migrate
* edit your .bash_profile with:
```
export GOOGLE_STORAGE_ACCESS_KEY_ID=your_google_key
export GOOGLE_STORAGE_SECRET_ACCESS_KEY=your_google_secret
export CLOUDINARY_API_KEY=your_cloudinary_key
export CLOUDINARY_API_SECRET=cloudinary_secret
```