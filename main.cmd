@echo off &TITLE è�������߱������нű� by hyx3179
echo main Options
echo=
echo      start        ���� ���ط�����
echo      restart      ���� ���ط�����
echo      stop         �ر� ���ط�����
echo      install      ��װ��������������ļ�
echo      upgrade      ���¸�������ѧ��
echo      hosts        ��� hosts ʵ���������ʣ��࿪��
echo      hosts edit   �� hosts �ļ��ֶ��༭
echo      kill         ǿ��ɱ������ nginx.exe ����
@REM echo      autostart    ��������������ûд��
echo=
echo ������Ҫ�Ĳ�����ֱ�ӻس���ʾ���в���
set/p "Options=>"
.\scripts\main.bat %Options%
