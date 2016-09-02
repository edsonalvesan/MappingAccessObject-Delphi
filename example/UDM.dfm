object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 302
  Top = 256
  Height = 236
  Width = 346
  object IBConexao: TIBDatabase
    DatabaseName = 'C:\Ikatec\ExpertDAORecord\DB\DADOS.FDB'
    Params.Strings = (
      'user_name=sysdba'
      'password=masterkey'
      'lc_ctype=ISO8859_1')
    LoginPrompt = False
    IdleTimer = 0
    SQLDialect = 3
    TraceFlags = []
    Left = 32
    Top = 8
  end
  object IBTranzacao: TIBTransaction
    Active = False
    DefaultDatabase = IBConexao
    Params.Strings = (
      'read_committed'
      'rec_version'
      'nowait')
    AutoStopAction = saNone
    Left = 136
    Top = 8
  end
end
