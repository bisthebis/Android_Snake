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

GameGrid::GameGrid(int w, int h) : width(w), height(h)
{
    //Valid input : size > 3 (4x4 minimum)
    Q_ASSERT(w);
    Q_ASSERT(h);

    auto gridSize = width * height;
    for (int i = 0; i < gridSize; ++i) {
        data.append(EMPTY);
    }

    Q_ASSERT(int(data.length()) == gridSize);

    initSnake();
    addFood();
}

GameGrid::CELL_STATE GameGrid::at(int x, int y) const {
    if (x >= width || y >= height)
        return EMPTY;

    int coord = x + y * width;
    Q_ASSERT(coord < data.length()); //Mathematically obvious.

    return data.at(coord);
}

void GameGrid::addFood() {
    QList<int> emptyCells;

    //Gather all IDs of empty cells
    for (int i = 0; i < width * height; ++i) {
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

    //World is a torus !
    x %= width;
    y %= height;

    //Where are we heading ?
    switch (at(x, y)) {
    case EMPTY:
        snake.append({x, y});
        snake.removeFirst();
        break;
    case FOOD:
        snake.append({x, y});
        break;
    case SNAKE:
        emit lost(snake.size());
        break;
    }
}


void GameGrid::initSnake() {
    //The snake begins point ont the right, as an horizontal bar in the middle
    static const int INITIAL_SIZE = 4;
    int averageHeight = height/2;
    int startingX = (width - INITIAL_SIZE) / 2;

    for (int i = 0; i < INITIAL_SIZE; ++i)
    {
        snake.append({startingX + i, averageHeight});
    }

    updateGrid();
}

void GameGrid::updateGrid() {
    //Cleaning
    for (int i = 0; i < width * height; ++i) {
        data[i] = EMPTY;
    }

    //Add food and Snake locations.
    data[foodLocation] = FOOD;

    for (const auto& cell : snake) {
        auto i = cell.first + cell.second * width;
        data[i] = SNAKE;
    }

    emit changed(-1);
}
