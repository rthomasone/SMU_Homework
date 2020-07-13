#Clone Branch to Linux Server

    ubuntu@k6-load-tester:~$ git clone -b ryan https://github.com/yaitouny/Spotrack_ETL.git
    Cloning into 'Spotrack_ETL'...
    remote: Enumerating objects: 52, done.
    remote: Counting objects: 100% (52/52), done.
    remote: Compressing objects: 100% (42/42), done.
    remote: Total 52 (delta 14), reused 38 (delta 6), pack-reused 0
    Unpacking objects: 100% (52/52), done. 

#Confirm Download

    ubuntu@k6-load-tester:~$ ll Spotrack_ETL/
    total 996
    drwxrwxr-x 4 ubuntu ubuntu   4096 Jun 24 17:26  ./
    drwxr-xr-x 7 ubuntu ubuntu   4096 Jun 24 17:26  ../
    drwxrwxr-x 8 ubuntu ubuntu   4096 Jun 24 17:26  .git/
    -rw-rw-r-- 1 ubuntu ubuntu   1825 Jun 24 17:26  .gitignore
    -rw-rw-r-- 1 ubuntu ubuntu   6466 Jun 24 17:26  ETL_Details.docx
    -rw-rw-r-- 1 ubuntu ubuntu   1792 Jun 24 17:26  README.md
    drwxrwxr-x 2 ubuntu ubuntu   4096 Jun 24 17:26  SQL/
    -rw-rw-r-- 1 ubuntu ubuntu  28206 Jun 24 17:26 'Spotify_Web Scape_3_Functions.ipynb'
    -rw-rw-r-- 1 ubuntu ubuntu 453631 Jun 24 17:26 'Spotify_Web Scrape_2_Export to Database.ipynb'
    -rw-rw-r-- 1 ubuntu ubuntu  33394 Jun 24 17:26  Spotify_Web_Scape_4_Viral_50.ipynb
    -rw-rw-r-- 1 ubuntu ubuntu 442495 Jun 24 17:26  Spotify_Web_Scrape_1_Initial.ipynb
    -rw-rw-r-- 1 ubuntu ubuntu    206 Jun 24 17:26  delete_all_rows_test.py
    -rw-rw-r-- 1 ubuntu ubuntu    532 Jun 24 17:26  requirements.txt
    -rw-rw-r-- 1 ubuntu ubuntu   3309 Jun 24 17:26  spotify.py
    -rw-rw-r-- 1 ubuntu ubuntu   1985 Jun 24 17:26  sqlHelper.py
    -rw-rw-r-- 1 ubuntu ubuntu   1467 Jun 24 17:26  webscrape_test.py


#Install Supporting Package for Virtual Environment

    ubuntu@k6-load-tester:~$ sudo apt install virtualenv -y


#Create Virtual Environment

    ubuntu@k6-load-tester:~$ virtualenv --python python3 \
    >     ~/envs/spotify
    Already using interpreter /usr/bin/python3
    Using base prefix '/usr'
    New python executable in /home/ubuntu/envs/spotify/bin/python3
    Also creating executable in /home/ubuntu/envs/spotify/bin/python
    Installing setuptools, pkg_resources, pip, wheel...done.


#Activate Virtual Environment

    ubuntu@k6-load-tester:~$ source \
    >     ~/envs/spotify/bin/activate
    (spotify) ubuntu@k6-load-tester:~$


#Install Python requirements

    (spotify) ubuntu@k6-load-tester:~$ cd Spotrack_ETL/
    (spotify) ubuntu@k6-load-tester:~/Spotrack_ETL$ pip install -r requirements.txt


#Execute Web Scraping Python File


    (spotify) ubuntu@k6-load-tester:~/Spotrack_ETL$ python3 webscrape_test.py 
    Scraping Spotify Top 200 Global
    position                                              title      artist  streams  source_id  chart_id  region_id
    0         1                       ROCKSTAR (feat. Roddy Ricch)      DaBaby  5379475          1         2          1
    1         2                                    Blinding Lights  The Weeknd  4614819          1         2          1
    2         3                              Roses - Imanbek Remix   SAINt JHN  3973534          1         2          1
    3         4                   Savage Love (Laxed - Siren Beat)   Jawsh 685  3370880          1         2          1
    4         5  death bed (coffee for your head) (feat. beabad...       Powfu  3267236          1         2          1


    Scraping Spotify Top 200 US
    position                         title          artist  streams  source_id  chart_id  region_id
    0         1  ROCKSTAR (feat. Roddy Ricch)          DaBaby  1521205          1         2          2
    1         2                    Party Girl  StaySolidRocky  1054184          1         2          2
    2         3               Blueberry Faygo       Lil Mosey   941424          1         2          2
    3         4               Blinding Lights      The Weeknd   915398          1         2          2
    4         5                    THE SCOTTS      THE SCOTTS   871482          1         2          2


    Scraping Spotify Top 200 UK
    position                            title      artist  streams  source_id  chart_id  region_id
    0         1     ROCKSTAR (feat. Roddy Ricch)      DaBaby   500863          1         2          3
    1         2  Rain On Me (with Ariana Grande)   Lady Gaga   346139          1         2          3
    2         3                      Breaking Me       Topic   328470          1         2          3
    3         4                Rover (feat. DTG)       S1mba   320647          1         2          3
    4         5                  Blinding Lights  The Weeknd   318384          1         2          3


    Scraping Spotify Viral 50 Global
    position                              title                     artist  streams  source_id  chart_id  region_id
    0         1                          I See Red  Everybody Loves an Outlaw      NaN          1         1          1
    1         2     Stunnin' (feat. Harm Franklin)              Curtis Waters      NaN          1         1          1
    2         3                            Marikit                Juan Caoile      NaN          1         1          1
    3         4                        Hard For Me            Michele Morrone      NaN          1         1          1
    4         5  Then Leave (feat. Queendome Come)                   Beatking      NaN          1         1          1


    Scraping Spotify Viral 50 US
    position                              title                     artist  streams  source_id  chart_id  region_id
    0         1                          I See Red  Everybody Loves an Outlaw      NaN          1         1          2
    1         2     Stunnin' (feat. Harm Franklin)              Curtis Waters      NaN          1         1          2
    2         3                        Hard For Me            Michele Morrone      NaN          1         1          2
    3         4  Then Leave (feat. Queendome Come)                   Beatking      NaN          1         1          2
    4         5                          Hood Baby                       KBFR      NaN          1         1          2


    Scraping Spotify Viral 50 UK
    position                           title                     artist  streams  source_id  chart_id  region_id
    0         1                       I See Red  Everybody Loves an Outlaw      NaN          1         1          3
    1         2  Stunnin' (feat. Harm Franklin)              Curtis Waters      NaN          1         1          3
    2         3          Who's That What''s That                     Niko B      NaN          1         1          3
    3         4                     Hard For Me            Michele Morrone      NaN          1         1          3
    4         5                         Feel It            Michele Morrone      NaN          1         1          3


    Loading Top 200 Global...


    Loading Top 200 US...


    Loading Top 200 UK...


    Loading Viral 50 Global...


    Loading  Viral 50 US...


    Loading  Viral 50 UK...



    Done!


#Create Cron Job

    (spotify) ubuntu@k6-load-tester:~/Spotrack_ETL$ crontab -e
    no crontab for ubuntu - using an empty one

    Select an editor.  To change later, run 'select-editor'.
    1. /bin/nano        <---- easiest
    2. /usr/bin/vim.basic
    3. /usr/bin/vim.tiny
    4. /bin/ed

    Choose 1-4 [1]: 1
    crontab: installing new crontab
    (spotify) ubuntu@k6-load-tester:~/Spotrack_ETL$ crontab -l
    # Edit this file to introduce tasks to be run by cron.
    # 
    # Each task to run has to be defined through a single line
    # indicating with different fields when the task will be run
    # and what command to run for the task
    # 
    # To define the time you can provide concrete values for
    # minute (m), hour (h), day of month (dom), month (mon),
    # and day of week (dow) or use '*' in these fields (for 'any').# 
    # Notice that tasks will be started based on the cron's system
    # daemon's notion of time and timezones.
    # 
    # Output of the crontab jobs (including errors) is sent through
    # email to the user the crontab file belongs to (unless redirected).
    # 
    # For example, you can run a backup of all your user accounts
    # at 5 a.m every week with:
    # 0 5 * * 1 tar -zcf /var/backups/home.tgz /home/
    # 
    # For more information see the manual pages of crontab(5) and cron(8)
    # 
    # m h  dom mon dow   command
    */5 * * * * /home/ubuntu/envs/spotify/bin/python3 /home/ubuntu/Spotrack_ETL/webscrape_test.py


#Enable Logging for cron

    (spotify) ubuntu@k6-load-tester:~/Spotrack_ETL$ sudo nano /etc/rsyslog.d/50-default.conf
    (spotify) ubuntu@k6-load-tester:~/Spotrack_ETL$ sudo cat /etc/rsyslog.d/50-default.conf | grep '/var/log/cron'
    cron.*                          /var/log/cron.log


#Restart rsyslog to Re-parse Configuration Changes

    (spotify) ubuntu@k6-load-tester:~/Spotrack_ETL$ sudo systemctl restart rsyslog
    (spotify) ubuntu@k6-load-tester:~/Spotrack_ETL$ sudo systemctl status rsyslog
    ● rsyslog.service - System Logging Service
    Loaded: loaded (/lib/systemd/system/rsyslog.service; enabled; vendor preset: enabled)
    Active: active (running) since Wed 2020-06-24 18:25:31 UTC; 7s ago
        Docs: man:rsyslogd(8)
            http://www.rsyslog.com/doc/
    Main PID: 4654 (rsyslogd)
        Tasks: 4 (limit: 1152)
    CGroup: /system.slice/rsyslog.service
            └─4654 /usr/sbin/rsyslogd -n

    Jun 24 18:25:31 k6-load-tester systemd[1]: Starting System Logging Service...
    Jun 24 18:25:31 k6-load-tester systemd[1]: Started System Logging Service.
    Jun 24 18:25:31 k6-load-tester rsyslogd[4654]: imuxsock: Acquired UNIX socket '/run/systemd/journal/syslog' (fd 3) from systemd.  [v8.32.0]
    Jun 24 18:25:31 k6-load-tester rsyslogd[4654]: rsyslogd''s groupid changed to 106


#Review cron.log to Confirm Execution

    spotify) ubuntu@k6-load-tester:~/Spotrack_ETL$ sudo cat /var/log/cron.log | grep webscrape_test.py
    Jun 24 18:30:01 k6-load-tester CRON[4684]: (ubuntu) CMD (/home/ubuntu/envs/spotify/bin/python3 /home/ubuntu/Spotrack_ETL/webscrape_test.py)
    Jun 24 18:35:01 k6-load-tester CRON[4712]: (ubuntu) CMD (/home/ubuntu/envs/spotify/bin/python3 /home/ubuntu/Spotrack_ETL/webscrape_test.py)
    Jun 24 18:40:01 k6-load-tester CRON[4724]: (ubuntu) CMD (/home/ubuntu/envs/spotify/bin/python3 /home/ubuntu/Spotrack_ETL/webscrape_test.py)
    Jun 24 18:45:01 k6-load-tester CRON[4751]: (ubuntu) CMD (/home/ubuntu/envs/spotify/bin/python3 /home/ubuntu/Spotrack_ETL/webscrape_test.py)
    Jun 24 18:50:01 k6-load-tester CRON[4762]: (ubuntu) CMD (/home/ubuntu/envs/spotify/bin/python3 /home/ubuntu/Spotrack_ETL/webscrape_test.py)
    Jun 24 18:55:01 k6-load-tester CRON[4789]: (ubuntu) CMD (/home/ubuntu/envs/spotify/bin/python3 /home/ubuntu/Spotrack_ETL/webscrape_test.py)
    Jun 24 19:00:01 k6-load-tester CRON[4800]: (ubuntu) CMD (/home/ubuntu/envs/spotify/bin/python3 /home/ubuntu/Spotrack_ETL/webscrape_test.py)
    Jun 24 19:05:01 k6-load-tester CRON[4826]: (ubuntu) CMD (/home/ubuntu/envs/spotify/bin/python3 /home/ubuntu/Spotrack_ETL/webscrape_test.py)
    Jun 24 19:10:01 k6-load-tester CRON[4836]: (ubuntu) CMD (/home/ubuntu/envs/spotify/bin/python3 /home/ubuntu/Spotrack_ETL/webscrape_test.py)
