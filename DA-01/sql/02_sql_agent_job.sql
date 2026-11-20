/* Nightly refresh job (fallback when Azure Data Factory is unavailable).
   SQL Server Express has no Agent; use Developer/Standard, or run bi.usp_RefreshStaging
   from Windows Task Scheduler via sqlcmd:
   sqlcmd -S . -d AdventureWorksDW -Q "EXEC bi.usp_RefreshStaging" */
USE msdb;
GO
EXEC dbo.sp_add_job @job_name = N'BI_Nightly_Refresh';
EXEC dbo.sp_add_jobstep @job_name = N'BI_Nightly_Refresh', @step_name = N'Refresh staging',
     @subsystem = N'TSQL', @database_name = N'AdventureWorksDW',
     @command = N'EXEC bi.usp_RefreshStaging;';
EXEC dbo.sp_add_jobschedule @job_name = N'BI_Nightly_Refresh', @name = N'Daily 0500',
     @freq_type = 4, @freq_interval = 1, @active_start_time = 050000;
EXEC dbo.sp_add_jobserver @job_name = N'BI_Nightly_Refresh';
GO
