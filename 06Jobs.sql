-- DROP JOB
BEGIN
  sys.dbms_scheduler.drop_job(job_name            => 'OGRBILSIS.MAILSMSJOB', 
			      FORCE		  => true);
end;
/


-- CREATE JOB
begin
  sys.dbms_scheduler.create_job(job_name            => 'OGRBILSIS.MAILSMSJOB',
                                job_type            => 'PLSQL_BLOCK',
                                job_action          => 'BEGIN MAIL_SMS_DOLDUR; END;',
                                start_date          => to_date('14-03-2023 00:00:00', 'dd-mm-yyyy hh24:mi:ss'),
                                repeat_interval     => 'Freq=Daily;Interval=1;ByHour=8',
                                end_date            => to_date(null),
                                job_class           => 'DBMS_JOB$',
                                enabled             => false,
                                auto_drop           => false,
                                comments            => 'KISILERE OZEL GUNLERDE MAIL VEYA SMS GONDERIR');
end;
/
