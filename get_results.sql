--���������� ������ ����������
select 
	�������������������������������.*,
	�����������������������������.����������� ��������������������,
	�������������������������������.������������������������������� * 1.0 / �����������������������������.����������� ������������������������������
	from
		(select
			��������������������.��������1,
			��������������������.��������2,
			count(��������������������.������) �������������������������������
			from (select
					���������������������.��������1,
					���������������������.��������2,
					���������������1.������
					from (select
							��������1.�������� ��������1,
							��������2.�������� ��������2
							from (select distinct �������� from [DataBase].[dbo].[��������������������] with (nolock)) ��������1
							cross join (select distinct �������� from [DataBase].[dbo].[��������������������] with (nolock)) ��������2
							where ��������1.�������� <> ��������2.��������) as ���������������������
					left join [DataBase].[dbo].[������������������������] as ���������������1 with (nolock)
					on ���������������������.��������1 = ���������������1.��������
					left join [DataBase].[dbo].[������������������������] as ���������������2 with (nolock)
					on ���������������������.��������2 = ���������������2.��������
					where ���������������1.������ = ���������������2.������) ��������������������
			group by
				��������������������.��������1,
				��������������������.��������2) �������������������������������

	inner join (select ��������, sum(datediff(minute, ����������, �����������)) ����������� from [DataBase].[dbo].[��������������������] with (nolock) group by ��������) �����������������������������
	on �������������������������������.��������1 = �����������������������������.��������

select count(*) from [DataBase].[dbo].[������������������������] with (nolock)

--������������������������������������������
select
	�������������������������������.�������������������������������������,
	count(*) ���������������������
	from
		(select 
			����������������.������,
			count(*) �������������������������������������
			from [DataBase].[dbo].[������������������������] ���������������� with (nolock)
			group by ����������������.������) �������������������������������
	group by �������������������������������.�������������������������������������
	order by �������������������������������.�������������������������������������

--�������� ����� ����������� ������
select 
	����������������.������,
	count(*) �������������������������������������
	from [DataBase].[dbo].[������������������������] ���������������� with (nolock)
	group by ����������������.������
	having count(*) = 5
	order by ����������������.������

--�������� �������� ������
set language english;
select * from [DataBase].[dbo].[������������������������] where ������ = '2011-12-28 12:00:00.000'

select 
	����������������.������,
	����������������.��������,
	����������������.�������������, 
	count(*) 
	from [DataBase].[dbo].[������������������������] ���������������� with (nolock) 
	group by
		����������������.������,
		����������������.��������,
		����������������.�������������
	having count(*) = 2
	order by count(*) desc, ����������������.������

select ������, count(*) from [DataBase].[dbo].[������������������������] where �������� in ('����� �� ������������', '��������') group by ������ having count(*) = 2 order by ������

