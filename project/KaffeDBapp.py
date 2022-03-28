import sqlite3

con = sqlite3.connect("project.db")



#####################################################################################
#Second user history, returns users which have most unique coffe tastings
def userHistory2():
  cursor = con.cursor()
  row = cursor.fetchall()
  print("Brukere som har smakt flest unike kaffer saa langt i aar:")
  for row in cursor.execute("""SELECT bruker.navn, COUNT(DISTINCT FerdibrentKaffe.kaffeID) AS AntallKaffer FROM Bruker
                                JOIN PostetAv ON PostetAv.brukerID = Bruker.brukerID
                                JOIN Kaffesmaking ON Kaffesmaking.smakingID = PostetAv.smakingID
                                JOIN SmakingAv ON SmakingAv.smakingID = Kaffesmaking.smakingID
                                JOIN FerdibrentKaffe ON FerdibrentKaffe.kaffeID = SmakingAv.kaffeID
                                WHERE Kaffesmaking.smaksAr LIKE '%2022%'
                                GROUP BY bruker.brukerID
                                ORDER BY AntallKaffer DESC"""):
        print(row)







#####################################################################################
#Third user history returns coffees that give most value for money
def userHistory3():
  cursor = con.cursor()
  row = cursor.fetchall()
  print("Kaffer som gir mest verdi for pengene:")
  for row in cursor.execute("""SELECT FerdibrentKaffe.kaffebrenneri,FerdibrentKaffe.navn , FerdibrentKaffe.kiloprisNOK, avg(Kaffesmaking.poeng) FROM FerdibrentKaffe
                              JOIN SmakingAv ON SmakingAv.kaffeID = FerdibrentKaffe.kaffeID
                              JOIN Kaffesmaking ON Kaffesmaking.smakingID = SmakingAv.smakingID
                              GROUP BY FerdibrentKaffe.kaffeID ORDER BY AVG(Kaffesmaking.poeng)/FerdibrentKaffe.kiloprisNOK DESC"""):
        print(row)





#####################################################################################
#Fourth user history, returns all coffee notes that contain word 'floral'
def userHistory4():
  cursor = con.cursor()
  row = cursor.fetchall()
  print("Kaffer som er beskrevet med ordet floral:")
  for row in cursor.execute("""SELECT DISTINCT FerdibrentKaffe.kaffebrenneri, FerdibrentKaffe.navn FROM FerdibrentKaffe
                              JOIN SmakingAv ON SmakingAv.kaffeID = FerdibrentKaffe.kaffeID
                              JOIN Kaffesmaking ON Kaffesmaking.smakingID = SmakingAv.smakingID
                              WHERE Kaffesmaking.smaksnotat LIKE '%floral%' or FerdibrentKaffe.beskrivelse LIKE '%floral%'"""):
        print(row)




#####################################################################################
#Fifth user history, returns all coffees from Colombia and Rwanda that are not washn
def userHistory5():
  cursor = con.cursor()
  row = cursor.fetchall()
  print("Kaffer som er fra Colombia eller Rwanda og ikke er vaskede:")
  for row in cursor.execute("""SELECT FerdibrentKaffe.kaffebrenneri,FerdibrentKaffe.navn FROM FerdibrentKaffe
                              JOIN FramstillesFra ON FramstillesFra.kaffeID = FerdibrentKaffe.kaffeID
                              JOIN Kaffeparti ON Kaffeparti.partiID = FramstillesFra.partiID
                              JOIN ProdusertAv ON ProdusertAv.partiID = Kaffeparti.partiID
                              JOIN Kaffegard ON Kaffegard.gardID = ProdusertAv.gardID
                              JOIN BestarAv ON BestarAv.partiID = Kaffeparti.partiID
                              JOIN Kaffebonner ON Kaffebonner.art = BestarAv.art
                              JOIN ForedletMed ON ForedletMed.art = Kaffebonner.art
                              JOIN Foredlingsmetode ON Foredlingsmetode.navn = ForedletMed.navn
                              WHERE Foredlingsmetode.navn != 'vasket' and (Kaffegard.land = 'Rwanda' or Kaffegard.land = 'Colombia')"""):
        print(row)



#####################################################################################  
#Loger inn eller registrer en ny bruker i database
#Innloging med feil data avslutter programmet
def logIn():
  cursor = con.cursor()
  print("Press 1 to login and 2 to register")
  choice = input()
  if choice == "1":
    email = input("email: ")
    password = input("password: ")
    print("")
    try:
      cursor.execute("SELECT brukerID FROM Bruker WHERE bruker.epost=? and bruker.passord=?", (email,password))
      data = cursor.fetchall()[0]
      print("Succesfully logged in")
      print("")
      return data[-1]
    except:
      print('User does not exist')
      quit()
  
  elif choice == "2":
    epost = str(input("epost: "))
    password = str(input("password: "))
    name = str(input("name: "))
    sql = "INSERT INTO Bruker(epost, passord, navn) VALUES('{}','{}','{}')".format(epost,password,name)
    cursor.execute(sql)
    con.commit()
    cursor.execute("SELECT brukerID FROM Bruker WHERE bruker.epost=? and bruker.passord=?", (epost,password))
    data = cursor.fetchall()[0]
    print("Profile created")
    print("")
    return data[-1]

  else:
    print("You have to start app one more time")
    quit()




#####################################################################################
#Funksjonen som tar inn id til bruker(om den er logget inn) og registrerer en ny smaking
def createTasting(id):
  cursor = con.cursor()
  print("Press 1 to create tasting and 2 to exit")
  choice = input()
  print("")
  if choice == "1":
    print("Choose what coffee you want to review, see list below and write coffee number:")
    numberOfCoffees = 0
    for row in cursor.execute("SELECT kaffeID, navn FROM Ferdibrentkaffe"):
      print(row)
    numberOfRows = cursor.execute("SELECT * FROM Ferdibrentkaffe")
    numberOfCoffees = len(numberOfRows.fetchall())
    tastingCoffe = int(input("Coffe number: "))
    if tastingCoffe > numberOfCoffees or tastingCoffe < 1:
      print("This coffee does not exist in database")
      quit()
    tastingDate = input("Date of tesing(for example 20.03.): ")
    tastingYear = int(input("Year of testing(for example 2020): "))
    tastingNotes = input("Notes(for example 'What a awesome floral coffee): ")
    tastingScore = int(input("Score from 1-10: "))
    if(tastingScore > 10 or tastingScore < 1):
      quit()
    sql = "INSERT INTO Kaffesmaking(poeng, smaksAr, smaksDato, smaksNotat,brukerID) VALUES('{}','{}','{}','{}','{}')".format(tastingScore,tastingYear,tastingDate, tastingNotes, id)
    cursor.execute(sql)
    con.commit()
    smakingID = cursor.execute('select * from Kaffesmaking').fetchall()[-1][0]
    sql = "INSERT INTO SmakingAv(smakingID, kaffeID) VALUES('{}','{}')".format(smakingID,tastingCoffe)
    cursor.execute(sql)
    con.commit()
    brukerID = id
    sql = "INSERT INTO PostetAv(brukerID, smakingID) VALUES('{}','{}')".format(brukerID,smakingID)
    cursor.execute(sql)
    con.commit()
    print("Tasting created")

  elif choice == "2":
    quit()

 

#####################################################################################
#Funksjonen som lar deg velge hvilken funksjon som skal kjores videre
def nextStep(id):
  print("What do you want to do next?")
  print("")
  print("To create new review press 1 (user history 1)")
  print("To exit press x")
  print("To watch userhistory 2 press 2")
  print("To watch userhistory 3 press 3")
  print("To watch userhistory 4 press 4")
  print("To watch userhistory 5 press 5")

  choice = input()

  if choice == "1":
    createTasting(id)
  if choice == "x":
    quit()
  if choice == "2":
    userHistory2()
  if choice == "3":
    userHistory3()
  if choice == "4":
    userHistory4()
  if choice == "5":
    userHistory5()



#####################################################################################
#Main funksjonen kjores nar programmet starter
def main():
  id = logIn()
  done = False
  while not done:
    nextStep(id)
    print("----------------------------")
    print("----------------------------")
  con.close()

main()





