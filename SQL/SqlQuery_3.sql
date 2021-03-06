﻿CREATE TABLE [dbo].[Groups] (
    [Id] [int] NOT NULL IDENTITY,
    [Description] [nvarchar](max),
    [SystemGroup] [tinyint] NOT NULL,
    [Group_Id] [int],
    [ParentGroup_Id] [int] NOT NULL,
    [RootParent_Id] [int] NOT NULL,
    CONSTRAINT [PK_dbo.Groups] PRIMARY KEY ([Id])
)
CREATE INDEX [IX_Group_Id] ON [dbo].[Groups]([Group_Id])
CREATE INDEX [IX_ParentGroup_Id] ON [dbo].[Groups]([ParentGroup_Id])
CREATE INDEX [IX_RootParent_Id] ON [dbo].[Groups]([RootParent_Id])
CREATE TABLE [dbo].[Ledgers] (
    [Id] [int] NOT NULL IDENTITY,
    [Description] [nvarchar](max),
    [LedgerHoderName] [nvarchar](max),
    [SystemLedger] [tinyint] NOT NULL,
    [ParentGroup_Id] [int] NOT NULL,
    CONSTRAINT [PK_dbo.Ledgers] PRIMARY KEY ([Id])
)
CREATE INDEX [IX_ParentGroup_Id] ON [dbo].[Ledgers]([ParentGroup_Id])
CREATE TABLE [dbo].[SubLedgers] (
    [Id] [int] NOT NULL IDENTITY,
    [Description] [nvarchar](max),
    [LedgerHoderName] [nvarchar](max),
    [SystemLedger] [tinyint] NOT NULL,
    [ParentLedger_Id] [int] NOT NULL,
    CONSTRAINT [PK_dbo.SubLedgers] PRIMARY KEY ([Id])
)
CREATE INDEX [IX_ParentLedger_Id] ON [dbo].[SubLedgers]([ParentLedger_Id])
ALTER TABLE [dbo].[Groups] ADD CONSTRAINT [FK_dbo.Groups_dbo.Groups_Group_Id] FOREIGN KEY ([Group_Id]) REFERENCES [dbo].[Groups] ([Id])
ALTER TABLE [dbo].[Groups] ADD CONSTRAINT [FK_dbo.Groups_dbo.Groups_ParentGroup_Id] FOREIGN KEY ([ParentGroup_Id]) REFERENCES [dbo].[Groups] ([Id])
ALTER TABLE [dbo].[Groups] ADD CONSTRAINT [FK_dbo.Groups_dbo.Groups_RootParent_Id] FOREIGN KEY ([RootParent_Id]) REFERENCES [dbo].[Groups] ([Id])
ALTER TABLE [dbo].[Ledgers] ADD CONSTRAINT [FK_dbo.Ledgers_dbo.Groups_ParentGroup_Id] FOREIGN KEY ([ParentGroup_Id]) REFERENCES [dbo].[Groups] ([Id]) ON DELETE CASCADE
ALTER TABLE [dbo].[SubLedgers] ADD CONSTRAINT [FK_dbo.SubLedgers_dbo.Ledgers_ParentLedger_Id] FOREIGN KEY ([ParentLedger_Id]) REFERENCES [dbo].[Ledgers] ([Id]) ON DELETE CASCADE
CREATE TABLE [dbo].[__MigrationHistory] (
    [MigrationId] [nvarchar](150) NOT NULL,
    [ContextKey] [nvarchar](300) NOT NULL,
    [Model] [varbinary](max) NOT NULL,
    [ProductVersion] [nvarchar](32) NOT NULL,
    CONSTRAINT [PK_dbo.__MigrationHistory] PRIMARY KEY ([MigrationId], [ContextKey])
)
INSERT [dbo].[__MigrationHistory]([MigrationId], [ContextKey], [Model], [ProductVersion])
VALUES (N'201605090659008_initialDBCreate', N'ERP.DataModel.Migrations.Configuration',  0x1F8B0800000000000400ED1CCB6EE336F05EA0FF20E8D416592BC95EDAC0DE45D649B641F3429C2C7A0B188976844A942A52818DA25FD6433FA9BF50EA45517C4894EC240E60EC251187C379CF7038D9FFFEF977FC791906D6334CB01FA1897D30DAB72D88DCC8F3D16262A764FEE167FBF3A7EFBF1B9F7AE1D2FA56C17DCCE0E84E8427F61321F191E360F70986008F42DF4D221CCDC9C88D4207789173B8BFFF8B7370E0408AC2A6B82C6B7C9B22E28730FF85FE3A8D900B639282E032F26080CBEF74659663B5AE4008710C5C38B14F6F6F462780801CD2B68E031F5022663098DB164028228050128FEE319C9124428B594C3F80E06E15430A3707018625E94735B82917FB8719174EBDB142E5A69844614F84071F4BB138E2F641C2B599D8A8E04EA980C92AE33A17DEC4FE9A44696C5BE24947D320C9A00AC15E440BDF0541BED987787442417D349A060063FA6B8E63CF2A5410EC317BA06693FDDBB3A66940D2044E104C499241DCA48F81EFFE065777D11F104D501A043C999450BAD6F8403FDD24510C13B2BA85F392F873CFB69CE63E47DCC8B6717B0ACECE11F978685B57F470F0184066059C1466244AE05788600208F46E00213041190E98CB513A5D38EB046237F1E34275C5A1D4FAA80FD9D625585E40B4204F139BFE685B67FE127AD59792907BE45397A39B4892C2AEB3662B4C6058AAB338EBCB8A40057F029E2BF0EC2F7276058C392E6C5BB730C897F1931F172E5568FCA102384BA2F0360AAA2DE5F7875994262E3DEF2E522CDE81640189393117D05B50B3525253AC3DDC8084AAA594404D93BCCA0EAF28538054C49BD2D7385C2B310D89D2A246762A1E4C09BC8D2252EC6FA18F0712C9ABD734D471002AE2C64E1D7C5A4352A18D35635281641794DE3628155AF895C227D987570A8295016D240A763976EFE0233A4F4B7C32A571963EB6C547B65C1E52C9A726530D21C5490D982A561A7B3BC3B9A6C3333C3B9FDFF9FC467CBE42B9498F129DBFC3F14C3CEA18E3C8F5730AF9C2ADAACE9A2C9F22CF6A2BD50A55B18280AA8B7A8C1F531FA1274FECFDD1E84012A306270B1E1D387F12D9E4186AE753117A7594B5C5E19ABE4A8DAD0476E135E5FBC016E3CA353A810124D03A768BCBE214601778B2E1524BF086894C63B83AF6BAACB866910BE3E6D2EB4A3B5D9A791311CA957CBB3B74D89C894F746035B7B8A19E26DD0EDA89535D15D6E65871BDD814C345609D4688D08A022625D3B48CC83EC125519426F71896D5092ED394487D867206897099AE6378937089F9E67656DE49FB2BCFE840C09788120ECE7905349CC0045ED8ED9F03517507440FEDC8408CEE5A648E218ACA2A3A5134EC80C219B0ACAAF265C6BB1292694AE238604A6B91424B127A0959E88A1F591E26D9A64FBEE1B8E1EDB945341D19A65BD003E4A368F5E87CC4CC52F4796488B7BC9699C81D259D147479C52CB30C91812297AC2382AA346719A47EA9708AA78AEA49C3D1BC698C2F411CD3FB11F7C6517EB166C503C7F4C3AC7FFB3F2C70382E56BC02306AD949F49209165058A547534ACFFC0493EC81E5116437A9A9174A605CBED4E4A2EAA0464A94755565A70A3CFB99A5E4FA9567A4F49B5A7267949990AA38E70B8AFA95F7E5EF4A200089E2A23E8D823444BACB7EDBEEC6D59B47D35830C7D7E8F3F3F81A0B32BEB123884594BB23095EAA989B6A3452721556876B599D340CD4ACDBF83EF42CB551789CD2625FFBA972B66C40EA42F00D2D88CBF4C38DA8AE70FBDB51CBDE9D296DA7293533B522EDB0DB4B6B6E6150461924AB32544FA8C215471686910915A8548694F732AADD3D692AAB9F8134F5A686D6079E9FF715CE71D69D659D59134EC502ACB7E65597B8F6ACD384354B300A91EB2F680305CF63DA8049E8AFA2AF62186B2B567723EDCC0602BC71E457C8B0FDA6B9969E4B541B5074FBFDFA7D285B71BD6E0FE2AD3EDC2F926FAD076B5B04EF49A77CAFA05DA53CE47A1A953B010325C621DA983EE56EC796A8536A788820ACC0638D0FA1C1312E9B0DDD939D52F7A100B12D4AFBB3EF659D87A2DCCCAD6434FB3398067E6E1915C02540FE1C6252BCF1DB87FB0787C284E8F64C6B3A187B81A259238D6C3635F60A530A3E73B6B63984AE37F7EEC104F40C12F709243F8460F9238F70E01424F1D12AA7BD2769756CE6F897DE81CE91079713FBAF7CD39175FEFB43B56FCFBA4EA8F11D59FBD6DF7DD910B3433F0A9ABB7574180941886AFDE8686CEE4146DF49C19D2BA8F069E67036E05ECD599BA1FEF546363E60306D675FEFD7BEB8BBD3100363DB376061EB0C6A6D6634AB2876FA8F6250BB8699347C10D08A0F9384D67C52CBEE26F191EBC72068D02D17AC26CE920991E113574E600C51E605126B2687B55DB91866C173BBF87F99993543C56F6E08CA92870A068DC76DB7B968DF01E493BA2FE9AF60313D47F68CF5F64276C3CD120D1B0F1C643D3D94BAA6F9B4BD24E92CA8B581F70A26D47364B1F760DD2ED36C6DF4E837B9B9D3FC4634DFD90BDCB8E285765C49873CB823AA4E31A4AA9F512D1A6F13DB7B8CA8868BFA57332B2562AE82BF849A3DBD2870EB46F244E45C7291F0736BAA23F463842F3FFA2ACF9C754FAE15DED5B56F3B065C8730D9D423FFCABAD573ABC664EB4A25E5A3E3B68EA26E95E1BEC498E99B30D86388547E3BA1A983FBBF3368FAC2FEA24691CD5D20E8369206833947F3A84A6102451588D059B984047834A31C27C49F0397D06517629CFF79DF3710A414E4347C84DE39BA4E499C12CA320C1F83C65F296639B0EDFC7C52B649F3F83A6F5EE14DB040C9F4290BF01A7D49FDC063749F29DA391A1459722DDB73992E49D6A65BAC18A6AB0819222AC5C76A823B18C6014586AFD10C3CC321B4DD63780117C05D554F607A24DD8A688A7D7CE2834502425CE2A8F7D35FA90D7BE1F2D3FFBB7CF77942460000 , N'6.1.3-40302')

