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
#include "gamegrid.h"
#include <QTextStream>

GameGrid::GameGrid(int w, int h) : m_width(w), m_height(h)
{
    //Valid input : size > 3 (4x4 minimum)
    Q_ASSERT(w);
    Q_ASSERT(h);

    auto gridSize = m_width * m_height;
    for (int i = 0; i < gridSize; ++i) {
        data.append(EMPTY);
    }

    Q_ASSERT(int(data.length()) == gridSize);

    initSnake();
    addFood();
}

GameGrid::CELL_STATE GameGrid::at(int x, int y) const {
    if (x >= m_width || y >= m_height)
        return EMPTY;

    int coord = x + y * m_width;
    Q_ASSERT(coord < data.length()); //Mathematically obvious.

    return data.at(coord);
}

void GameGrid::addFood() {
    QList<int> emptyCells;

    //Gather all IDs of empty cells
    for (int i = 0; i < m_width * m_height; ++i) {
        if (data.at(i) == FOOD)
            data[i] = EMPTY; //Cleanup
        if (data.at(i) == EMPTY)
            emptyCells.append(i);
    }

    //Pick one randomly, make it a FOOD cell
    foodLocation = qrand() % emptyCells.length();
    updateGrid();
}

void GameGrid::advance(DIRECTION d) {
    auto head = snake.last();

    int x = head.first;
    int y = head.second;


    switch (d) {
    case LEFT:
        --x;
        break;
    case RIGHT:
        ++x;
        break;
    case UP:
        --y;
        break;
    case BOTTOM:
        ++y;
        break;
    }

    //Check that the snake doesn't go backward (behind head)
    auto cell = QPair<int, int>(x, y);
    if (cell == *(snake.end() - 2)) {
        emit failedDirectionSwitch();
        return;
    }

    //To avoid negative modulos
    x += m_width;
    y += m_height;
    //World is a torus !
    x %= m_width;
    y %= m_height;

    //Where are we heading ?
    switch (at(x, y)) {
    case EMPTY:
        snake.append({x, y});
        snake.removeFirst();
        updateGrid();
        break;
    case FOOD:
        snake.append({x, y});
        updateGrid();
        addFood();
        break;
    case SNAKE:
        emit lost(snake.size());
        break;
    }

    if (d != m_lastDirection) {
        m_lastDirection = d;
        emit lastDirectionChanged(d);
    }


}


void GameGrid::initSnake() {
    //The snake begins point ont the right, as an horizontal bar in the middle
    static const int INITIAL_SIZE = 4;
    int averageHeight = m_height/2;
    int startingX = (m_width - INITIAL_SIZE) / 2;

    for (int i = 0; i < INITIAL_SIZE; ++i)
    {
        snake.append({startingX + i, averageHeight});
    }

    updateGrid();
}

void GameGrid::updateGrid() {
    //Cleaning
    for (int i = 0; i < m_width * m_height; ++i) {
        data[i] = EMPTY;
    }

    //Add food and Snake locations.
    data[foodLocation] = FOOD;

    for (const auto& cell : snake) {
        auto i = cell.first + cell.second * m_width;
        data[i] = SNAKE;
    }

    //Ensure food isn't on the snake
    if (data.at(foodLocation) == SNAKE)
        addFood();

    emit changed(-1);
}

void GameGrid::toStdOut() const {
    static QTextStream out(stdout);

    static QMap<GameGrid::CELL_STATE, QChar> symbols;

    symbols[GameGrid::EMPTY] = '0';
    symbols[GameGrid::FOOD] = 'F';
    symbols[GameGrid::SNAKE] = '=';

    for (int y = 0; y < m_height; ++y) {
        for (int x = 0; x < m_width; ++x) {
            out << symbols[at(x, y)] << ' ';
        }
        out << endl;
    }
}
