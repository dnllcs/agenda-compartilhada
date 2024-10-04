const createTables = [
  '''
  CREATE TABLE user (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    email TEXT NOT NULL UNIQUE, 
    password TEXT NOT NULL,
    status TEXT);
  ''',
  '''
  CREATE TABLE notification (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      user_id INTEGER NOT NULL,
      type TEXT NOT NULL,
      title TEXT NOT NULL,
      content TEXT NOT NULL,
      FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE);
  ''',
  '''
  CREATE TABLE message (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      event_id INTEGER NOT NULL,
      user_id INTEGER NOT NULL,
      type TEXT NOT NULL,
      body TEXT NOT NULL,
      read INTEGER NOT NULL,
      FOREIGN KEY (event_id) REFERENCES event(id) ON DELETE CASCADE,
      FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
      );
  ''',
  '''
  CREATE TABLE event (
      id INTEGER PRIMARY KEY AUTOINCREMENT, 
      location TEXT NOT NULL,
      user_id INTEGER NOT NULL,
      description TEXT, 
      date TEXT NOT NULL, 
      createdAt TEXT NOT NULL DEFAULT (datetime('now')), 
      visibility TEXT NOT NULL,
      FOREIGN KEY (user_id) REFERENCES user(id) ON DELETE CASCADE
      );
  '''
];

const userInserts = [
  'INSERT INTO user (name, email, password, status) VALUES ("Daniels", "Danielsemail", "Danielspassword", "S");',
  'INSERT INTO user (name, email, password, status) VALUES ("Daniels2", "Daniels2email", "Daniels2password", "S");',
  'INSERT INTO user (name, email, password, status) VALUES ("Daniels3", "Daniels3email", "Daniels3password", "S");'
];
const eventInserts = [
  'INSERT INTO event (location, user_id, description, date, visibility) VALUES ("EVENTO - 1", 1, "Encontro de amigos", "2024-10-10 15:00:00", "public");',
  'INSERT INTO event (location, user_id, description, date, visibility) VALUES ("EVENTO - 2", 1, "Reuniao de trabalho", "2024-10-12 10:00:00", "private");',
  'INSERT INTO event (location, user_id, description, date, visibility) VALUES ("EVENTO - 3", 2, "Festa de aniversário", "2024-10-20 18:00:00", "public");'
];
const messageInserts = [
  'INSERT INTO message (event_id, user_id, type, body, read) VALUES (1, 1, "text", "Minha mensagem - 1", 0);',
  'INSERT INTO message (event_id, user_id, type, body, read) VALUES (2, 1, "text", "Minha mensagem - 2", 1);',
  'INSERT INTO message (event_id, user_id, type, body, read) VALUES (3, 2, "text", "Minha mensagem - 3", 0);'
];
