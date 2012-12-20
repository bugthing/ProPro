ProPro
======

ProPro is my personal project and fulfils a few roles, mainly it will help
me learn Rails and related tech better, but also I think the overall idea is 
not too bad.

Originally I started this in Perl, but I got abit bogged down with having to 
manage every aspect myself (which is my failing, not Perl!) .. I thought I'd 
give it another blast, this time using Ruby and Rails.

So this is a re-write of Flowella, this time it should be cleaner and using 
Rails should be abit nicer to manage.

I am using [OpenShift](http://propro-bugthing.rhcloud.com/) to host this project
as not only do RedHat provide a great service for free, but if (for some amazing
reason) it gets used, it can be easily stepped up.

Try it yourself
===============

If you want to see what this thing is about, give it a try. You will need to have
Ruby 1.9 installed, including Bundler. If you are reading this, you probably know
what to do there! .. for my project, this should be enough:

    git clone git@github.com:bugthing/ProPro.git
    cd ProPro
    bundle install
    rake db:create
    rake db:migrate
    rake db:seed
    rails s


Used to build this thing
========================

[BootStrap](http://twitter.github.com)
[Rails](http://guides.rubyonrails.org)
[jQuery](http://jquery.com)
[JSPlumb](http://www.jsplumb.org)
[Deploy Upon](http://openshift.redhat.com)
