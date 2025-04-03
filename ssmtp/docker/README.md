# README

ssmtp is a simple send-only emulation for `sendmail` (see [manpage](https://linux.die.net/man/8/ssmtp) for config files).

An example:

    echo -e 'Subject: Test 1\r\n\r\nAnother test' | docker run --rm -i -v $PWD/ssmtp.conf:/etc/ssmtp/ssmtp.conf:ro -v $PWD/revaliases:/etc/ssmtp/revaliases:ro ghcr.io/eosc-lot-1/ssmtp:2 ssmtp -F 'Someone' -v foobar@example.net

