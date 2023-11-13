# Экспертная система Лаб. 1
# ФИО автора: Леонов Владислав Денисович
# E-mail автора: bourhood@gmail.com
# Группа: 224-322
# Университет: Московский Политехнический Университет
########################################################################################################################

# Загружаем библиотеки
import os
import sys                                                            # Предоставляет системе особые параметры и функции
import sqlite3                                                        # Работа с базой данных
import numpy as np                                                    # Для работы с массивами

# Библиотеки GUI интерфейса (pip install PyQt5) (Qt Designer to edit *.ui - https://build-system.fman.io/qt-designer-download)
from PyQt5 import uic
from PyQt5.QtWidgets import *
from PyQt5.QtCore import *
from PyQt5.QtGui import *

''' -------- Главная форма ------- '''   
class Window(QMainWindow):       
    def __init__(self, *args, **kwargs):
        super(Window, self).__init__(*args, **kwargs)

        # Настройки и запуск формы
        self.need_exit = False
        self.load_def_ui()                                            

        # Настройка формы
        self.ui.scrollArea.setStyleSheet("QScrollArea {background-color:transparent;}")
        self.ui.scrollAreaWidgetContents.setStyleSheet("background-color:transparent;")
        self.ui.scrollArea_2.setStyleSheet("QScrollArea {background-color:transparent;}")
        self.ui.scrollAreaWidgetContents_2.setStyleSheet("background-color:transparent;")

        self.ui.label_Question.setText("Пусто, вопросы спят ^_^")
        self.ui.groupBox_Question.setTitle("")
        self.ui.label_Question_Image.hide()
        self.ui.label_Question_Image.setText("")

        self.ui.comboBox_Answers.setVisible(False) 
        self.ui.textEdit_Answers.setVerticalScrollBarPolicy(Qt.ScrollBarAlwaysOff)

        # Подписки на события
        self.ui.pushButton_Answers.clicked.connect(self.pushButton_Answers_Clicked)
        self.ui.pushButton_SendAnswer.clicked.connect(self.pushButton_SendAnswer_Clicked)

        # Приветствие пользователя
        self.show_messageBox_StartInfo()

        # Соединение с базой данных
        self.connect_db_sqlite3()

        # Получаем первый вопрос
        self.select_question_id = 0
        self.count_questions_were_asked = 0
        self.max_question_id = self.sql.execute("SELECT count(id) FROM QuestTable").fetchall()[0][0]
        self.show_question(self.select_question_id)
        
    def load_def_ui(self):
        # Настройки окна главной формы
        file_ui_path = 'GUI.ui' if os.path.isfile('GUI.ui') is True else 'L1/GUI.ui'
        self.file_icon_path = 'Images/_AppImages/surflay.ico' if os.path.isfile('Images/_AppImages/surflay.ico') is True else 'L1/Images/_AppImages/surflay.ico'
        self.ui = uic.loadUi(file_ui_path)                            # GUI, должен быть в папке с main.py
        self.ui.setWindowTitle('Леонов Владислав 224-322 - Лаб. 1')   # Название главного окна
        self.ui.setWindowIcon(QIcon(self.file_icon_path))             # Иконка на гланое окно
        self.ui.show()                                                # Открываем окно формы  

    def show_messageBox_StartInfo(self): 
        '''Приветствие пользователя'''
        msg = QMessageBox() 
        msg.setIcon(QMessageBox.Information) 
        msg.setText("Данная программа поможет Вам определиться с выбором автомобиля. Спасибо, что выбрали данную экспертную систему!\n\nДля редактирования базы данных, необходимо изменить содержимое файла QuestionsAndAnswers.sql и перезапустить программу.") 
        msg.setWindowTitle("Приветствие ^_^") 
        msg.setStandardButtons(QMessageBox.Ok) 
        msg.setWindowIcon(QIcon(self.file_icon_path ))           
        msg.exec_() 

    def connect_db_sqlite3(self):
        # Считываем значения из файла *.sql
        init_sql_file = open("QuestionsAndAnswers.sql", encoding='utf-8').read()
        # Подключаем к БД или создаем ноый файл *.db 
        self.db = sqlite3.connect("QuestionsAndAnswers.db")
        self.sql = self.db.cursor()
        # Инициализируем в БД таблицу вопросов и ответов
        self.sql.executescript(init_sql_file)
        self.db.commit()

    def show_question(self, question_id):
        # Получаем вопрос из БД
        self.count_questions_were_asked += 1
        self.ui.groupBox_Question.setTitle(f"Вопрос {self.count_questions_were_asked} (ID = {question_id})")
        question = self.sql.execute(f"SELECT question FROM QuestTable WHERE id = {question_id}").fetchall()[0][0]
        self.ui.label_Question.setText(question)
        
        # Очищаем поля ввода данных
        self.ui.comboBox_Answers.clear()
        self.ui.textEdit_Answers.setText("")
        self.ui.comboBox_Answers.setVisible(False) 
        self.ui.textEdit_Answers.setVisible(False) 
        self.ui.pushButton_Answers.setVisible(False) 

        # Выставляем картинку вопроса
        imagePath = self.sql.execute(f"SELECT imagePath FROM QuestTable WHERE id = {question_id}").fetchall()[0][0]
        self.setImageOn_Label_Question_Image(imagePath)

        # Выставляем варианты ответа в поля ввода данных
        question_answers = self.sql.execute(f"SELECT answers FROM QuestTable WHERE id = {question_id}").fetchall()[0][0]
        if "[" in question_answers and "]" in question_answers:
            question_answers_list = question_answers.split(";")
            for answer in question_answers_list:
                if "[Поле ввода текста]" in answer:
                    self.ui.textEdit_Answers.setVisible(True) 
                elif "[Кнопка-" in answer and "]" in answer:
                    textBtn = answer.replace("[Кнопка-", "")
                    textBtn = textBtn.replace("]", "")
                    self.ui.pushButton_Answers.setText(textBtn)
                    self.ui.pushButton_Answers.setVisible(True) 
        else:
            # ComboBox
            question_answers_list = question_answers.split(";")
            self.ui.comboBox_Answers.clear()
            self.ui.comboBox_Answers.addItems(question_answers_list)
            self.ui.comboBox_Answers.setVisible(True) 

    def pushButton_SendAnswer_Clicked(self):
        # Если стоит флаг выхода из приложения, закрываем приложение
        if self.need_exit: exit(); 

        # Получаем пользовательский ответ на вопрос
        answerText = self.ui.textEdit_Answers.toPlainText()
        if answerText is None or '' == answerText: answerText = self.ui.comboBox_Answers.currentText(); 
        if answerText is None or '' == answerText:
            QMessageBox(QMessageBox.Warning, "Внимание!", "Необходимо значение ответа!").exec()
            return
        
        # Обрабатываем ответ, если не стоит флага игнорирования
        is_need_ignored_question = self.sql.execute(f"SELECT ignored FROM QuestTable WHERE id = {self.select_question_id}").fetchall()[0][0]
        if is_need_ignored_question == 0:
            # Обрабатываем ответ ("Не знаю")
            if answerText == "Не знаю":
                question_rules = self.sql.execute(f"SELECT questionRulesIfDontKnow FROM QuestTable WHERE id = {self.select_question_id}").fetchall()[0][0]
                lines_command = question_rules.replace("\"", "'").split(";")
                for line in lines_command: self.db.execute(line); 
            # Обрабатываем ответ
            else:
                useQRulesIfAnswer = self.sql.execute(f"SELECT useQRulesIfAnswer FROM QuestTable WHERE id = {self.select_question_id}").fetchall()[0][0]
                # Если нет определенного значения для ответа ИЛИ значение совпадает с ответом, то выполняем правила и редактируем ответы
                if useQRulesIfAnswer == '' or useQRulesIfAnswer is None or useQRulesIfAnswer == answerText:
                    question_rules = self.sql.execute(f"SELECT questionRules FROM QuestTable WHERE id = {self.select_question_id}").fetchall()[0][0]
                    lines_command = question_rules.replace("\"", "'").replace("{}", str(answerText)).split(";")
                    for line in lines_command: self.db.execute(line); 

        # Проверяем необходимость вывести итоговый результат
        select_answers_count = self.sql.execute("SELECT count(id) FROM AnswTable").fetchall()[0][0]
        # Если закончились вопросы, то выводим все оставшиеся результаты
        next_quest_id = self.select_question_id + 1
        if select_answers_count > 1 and (self.select_question_id >= self.max_question_id or next_quest_id >= self.max_question_id):
            namesAutoStr = ""
            nameAutoList = self.sql.execute("SELECT nameAuto FROM AnswTable").fetchall()
            for i, nameAutoSql in enumerate(nameAutoList):
                if nameAutoSql == "" or nameAutoSql is None: continue; 
                nameAuto = nameAutoSql[0]
                if nameAuto == "" or nameAuto is None: continue; 
                namesAutoStr += f"{i + 1}) {nameAuto}\n"
            if namesAutoStr == "" or namesAutoStr is None:
                self.ui.groupBox_Question.setTitle("Итог")
                self.ui.label_Question.setText("По вашим критериям автомобиля не найдено!")
                self.setImageOn_Label_Question_Image('Images/AnswersImages/NoAuto.png')
            else:
                self.ui.groupBox_Question.setTitle("Итог")
                self.ui.label_Question.setText(f"На основе базы данных были подобраны идеальные дла Вас варианты!\nВарианты:\n{namesAutoStr}")
            self.need_exit = True
            return

        # Если нет больше ответов в БД, то выводим пользователю об этом сообщение
        if select_answers_count == 0:
            self.ui.groupBox_Question.setTitle("Итог")
            self.ui.label_Question.setText("По вашим критериям автомобиля не найдено!")
            self.setImageOn_Label_Question_Image('Images/AnswersImages/NoAuto.png')
            self.need_exit = True
            return
        
        # Если остался 1 ответ в БД, то выводим результат
        if select_answers_count == 1:
            nameAuto = self.sql.execute("SELECT nameAuto FROM AnswTable LIMIT 1").fetchall()[0][0]
            self.ui.groupBox_Question.setTitle("Итог")
            self.ui.label_Question.setText(f"На основе базы данных был подобран идеальный дла Вас вариант!\n{nameAuto}")
            imagePath = self.sql.execute("SELECT imagePath FROM AnswTable LIMIT 1").fetchall()[0][0]
            self.setImageOn_Label_Question_Image(imagePath)
            self.need_exit = True
            return

        # Переходим к следующему вопросу
        self.select_question_id += 1
        # Если стоит игнорирование вопроса, то переходим к следующему и сново заходим в данный метод
        is_need_ignored_next_question = self.sql.execute(f"SELECT ignored FROM QuestTable WHERE id = {self.select_question_id}").fetchall()[0][0]
        if is_need_ignored_next_question != 0: self.pushButton_SendAnswer_Clicked(); 
        # Иначе переходим и выводим вопрос
        else: self.show_question(self.select_question_id); 

    def pushButton_Answers_Clicked(self):
        self.ui.textEdit_Answers.setText("Не знаю")
        self.pushButton_SendAnswer_Clicked()
        self.ui.textEdit_Answers.setText("")

    def setImageOn_Label_Question_Image(self, filePath):
        if not os.path.isfile(filePath): filePath = "L1/" + filePath; 
        if os.path.isfile(filePath): self.ui.label_Question_Image.show(); 
        else: self.ui.label_Question_Image.hide(); return; 
        pixmap = QPixmap(filePath)
        size = pixmap.size()
        ratio = size.width() / size.height()
        width = ratio *self.ui.label_Question_Image.height()
        self.ui.label_Question_Image.setPixmap(pixmap.scaled(int(width), int(self.ui.label_Question_Image.height())))

''' -------- Запуск формы ------- '''
if __name__ == '__main__':                                            # Выполнение условия, если запущен этот файл python, а не если он подгружен через import
    app = QApplication(sys.argv)                                      # Объект приложения (экземпляр QApplication)
    win = Window()                                                    # Создание формы
    sys.exit(app.exec_())                                             # Вход в главный цикл приложения и Выход после закрытия приложения