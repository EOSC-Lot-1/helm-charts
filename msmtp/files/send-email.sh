subject=$(date -d "${REF_DATE}" +"${EMAIL_SUBJECT}")
attachmentArgs=( )
i=0
while true; do
  varForName="EMAIL_ATTACHMENTS_${i}_NAME"
  varForPath="EMAIL_ATTACHMENTS_${i}_PATH"
  test -v ${varForName} || break;
  if (( i == 0 ));
    then attachmentArgs+=( "-a" );
  fi
  path=$(date -d "${REF_DATE}" +"./attachments/${!varForPath}")
  test -f ${path}
  attachmentName=$(date -d "${REF_DATE}" +"${!varForName}")
  ln -s ${path} ${attachmentName}
  attachmentArgs+=( ${attachmentName} )
  # next attachment
  i=$(( i + 1 ))
done
mutt -s "${subject}" ${attachmentArgs[@]} -- ${TO_EMAIL} <<<"${EMAIL_BODY}"
