#pragma once
#include<string>
#include<math.h>
#include<iostream>
#include<vector>
#include"Line.h"
const double eps = 0.00000001;
const double radius = 6371.0;
const double pi = 3.1415926;
using namespace std;
enum TYPE{ INTPOINT = 0,DOUBLEPOINT };
class Point
{
private:
	double x, y;
	int type;
public:
	Point(int,int);
	Point(double, double);
	~Point();
	int getItem(int);//获取X/Y坐标
	int getDimension();//获取坐标维数
	bool isEqual(Point);//判断与另一个点是否为同一点
	bool isDifferent(Point);//判断与另一个点是否为不同点
	bool isGreaterThan(Point);//判断一个点的横坐标是否大于另一个点的
	bool isLessThan(Point);//判断一个点的横坐标是否小于另一个点的
	string getXYString();//返回包含坐标信息的字符串
	double getEuclideanDistance(Point);//返回与另一个点的欧氏距离
	double getManhattanDistance(Point);//返回与另一个点的曼哈顿距离
	double getGreatCircleDistance(Point);//返回球面上两点间的大地线距离
	//double getDistance2Segment(SimpleSegment);
	double getDistance2Segment(Point, Point);
};
template <class T> double radian(T);
