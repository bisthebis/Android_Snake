/*
MIT License

Copyright (c) 2017 Boris Martin

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
*/
#include "gamedata.h"

#include <QStandardPaths>
#include <QJsonDocument>
#include <QJsonObject>
#include <QFile>
#include <QCoreApplication>
#include <QtGlobal>

GameData::GameData(QObject *parent) : QObject(parent)
{
    //Load data or create dummy data if it is corrupt/nonexistent.
    auto path = QStandardPaths::standardLocations(QStandardPaths::AppDataLocation);
    QFile file(path[0] + "/snake_data.json");
    if (file.open(QFile::ReadOnly)) {
        auto fileContent = file.readAll();
        QJsonDocument data = QJsonDocument::fromJson(fileContent);

        //Acquire data and ensure it is correct
        m_lastSpeed = data.object()["lastSpeed"].toInt(-1);
        m_highscore = data.object()["highscore"].toInt(-1);

        if (m_lastSpeed < 1 || m_lastSpeed > 20 || m_highscore < 0)
        {
            m_lastSpeed = 5;
            m_highscore = 0;
            doSave(); //Data corrupt; erase it and save
        }
    }
    else //No data, create initial data
        doSave();

    connect(this, &GameData::highscoreChanged, this, &GameData::doSave);
    connect(this, &GameData::lastSpeedChanged, this, &GameData::doSave);
}

void GameData::doSave() {
    auto path = QStandardPaths::standardLocations(QStandardPaths::AppDataLocation);
    QFile file(path[0] + "/snake_data.json");
    if (!file.open(QFile::WriteOnly)) {
        qFatal("Couldn't open data file...");
        qApp->exit(-1);
    }

    QJsonObject data;
    data["lastSpeed"] = m_lastSpeed;
    data["highscore"] = m_highscore;

    QJsonDocument doc(data);
    file.write(doc.toJson());

}
