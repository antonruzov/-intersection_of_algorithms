set language english;

insert into [DataBase].[dbo].[������������������������]
select
	�����������.������,
	�����������.��������,
	(case when ���������������������.�������� is not null then 1 else 0 end) ���������������
	from (select
			�����.[time] ������,
			��������.��������
			from [DataBase].[dbo].[time] ����� with (nolock)
			cross join (select distinct �������� from [DataBase].[dbo].[��������������������] with (nolock)) ��������) �����������
	left join [DataBase].[dbo].[��������������������] ��������������������� with (nolock) 
	on �����������.�������� = ���������������������.��������
		and �����������.������ >= ���������������������.����������
		and �����������.������ <= ���������������������.�����������
	where (case when ���������������������.�������� is not null then 1 else 0 end) = 1
	order by
		�����������.������,
		�����������.��������