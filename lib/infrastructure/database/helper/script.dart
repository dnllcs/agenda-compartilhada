const createTables = [
  '''
  CREATE TABLE User (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE, 
    password TEXT NOT NULL,
    status TEXT);
  ''',
  '''
  CREATE TABLE Notification (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      type TEXT NOT NULL,
      title TEXT NOT NULL,
      content TEXT NOT NULL);
  ''',
  '''
  CREATE TABLE Message (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      type TEXT NOT NULL,
      body TEXT NOT NULL,
      read INTEGER NOT NULL);
  ''',
  '''
  CREATE TABLE Event (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      location TEXT NOT NULL,
      description TEXT, 
      date TEXT NOT NULL, 
      createdAt TEXT NOT NULL DEFAULT (datetime('now')), 
      visibility TEXT NOT NULL);
  '''
];
