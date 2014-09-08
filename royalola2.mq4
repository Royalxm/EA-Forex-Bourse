//+------------------------------------------------------------------+
//|                                                     royalola.mq4 |
//|                           Copyright 2014, Royalxm he fuck all EA |
//|                                      http://worldwide-invest.org |
//+------------------------------------------------------------------+
#property copyright "Copyright 2014, Royalxm he fuck all EA"
#property link      "http://worldwide-invest.org"
#property version   "1.00"
#property strict
//+------------------------------------------------------------------+
//| Expert initialization function                                   |
//+------------------------------------------------------------------+


double tabpriceup[4];
double tabpricedown[4];
double moyenne;
double limitebuy=0.00100;
double limiteshell=-0.00015;
double achat=0.00010;
double vente=-0.00015;
int boolbuy=0;
int cmbord=0;
int urgent;
datetime timesell;
double lots=1.0;


double distancebuy;   
int i=0;
int boolt=0;

string timeupload;

/*
double Lotsop()
{




}*/


int OnInit()
  {
//---
      timeupload = TimeToStr(Time[0]);
   tabpriceup[0] = iHigh(NULL,PERIOD_M5,2);
   tabpriceup[1] = iHigh(NULL,PERIOD_M5,1);
   tabpricedown[0] = iHigh(NULL,PERIOD_M5,2);
   tabpricedown[1] = iHigh(NULL,PERIOD_M5,1);
   boolt=1;
   i=2;
   cmbord=0;
   urgent = 0;
//---
   return(INIT_SUCCEEDED);
  }
//+------------------------------------------------------------------+
//| Expert deinitialization function                                 |
//+------------------------------------------------------------------+
void OnDeinit(const int reason)
  {
//---
   
  }
  
  
void lot()
{
   double balance =  AccountBalance();
   double bb;
   balance = balance / 1000;
   bb = NormalizeDouble(balance,1);
   
   lots = bb;


}
//+------------------------------------------------------------------+
//| Expert tick function                                             |
//+------------------------------------------------------------------+
void OnTick()
  {

 int i2 = 0;
   
   int h=TimeHour(TimeCurrent());
   int mi=TimeMinute(TimeCurrent());
   int da=TimeDay(TimeCurrent());
   int moi=TimeMonth(TimeCurrent());
   int heure = 0;
   int jour= 0;
   jour = da * 100;
   jour = jour + moi;
   heure = h * 100;
   heure = heure + mi;
   
   Print(" timeu :", jour);
   Print(" timeu :", timeupload);
   double vbid = MarketInfo(Symbol(),MODE_BID);
   double vask = MarketInfo(Symbol(),MODE_ASK);
     
   Print("Symbol=",Symbol());
   Print("Last incoming bid price="+ vbid);
   Print("Last incoming ask price=",vask);





 if(StringCompare(timeupload,TimeToStr(Time[0])) != 0)
   {
      tabpriceup[i] = iHigh(NULL,PERIOD_M5,1);
      if(i != 4)
      {
         i = i + 1;
      }
      timeupload = TimeToStr(Time[0]);
      if( i == 4)
      {
         tabpriceup[0] = tabpriceup[1];
         tabpriceup[1] = tabpriceup[2];
         tabpriceup[2] = tabpriceup[3];
          i = 3;
      }
    boolt = 0;
}



   if(i == 3 &&  boolt == 0)
   {
   ObjectDelete("Moyenne");
   ObjectDelete("buy");
   ObjectDelete("Moyennes");
 vbid = MarketInfo(Symbol(),MODE_BID);
 vask = MarketInfo(Symbol(),MODE_ASK);
   moyenne = vask - vbid;
   limitebuy=achat;
     moyenne = tabpriceup[0] + tabpriceup[1];
     moyenne = moyenne + tabpriceup[2];
     moyenne = moyenne /3;
     printf("Moyenne:  " + moyenne);

   ObjectCreate("Moyenne", OBJ_HLINE, 0, Time[0], moyenne, 0, 0);
   limitebuy = limitebuy + moyenne;
    ObjectSet("Moyenne", OBJPROP_COLOR,Red );
    ObjectCreate("buy", OBJ_HLINE, 0, Time[0], limitebuy, 0, 0);
     ObjectSet("buy", OBJPROP_COLOR,Lime );
     
     
      boolt = 1;
      
      
   }
   
   
  //----
  //----
  if(cmbord < 0)
      cmbord = 0;
if(((jour < 2702)|(jour > 2802)) &&((jour < 2012)|(jour > 3112)) && ((heure < 1550)|(heure > 1800)) && ((heure < 0200)|(heure > 0300)) && ((heure < 0450)|(heure > 0458)) && ((heure < 0700)|(heure > 0910)) && ((heure < 0945)|(heure > 0957)) && ((heure < 1100)|(heure > 1320)) && ((heure < 1915)|(heure > 2015))&& ((heure < 1500)|(heure > 1515))&& ((heure < 2115)|(heure > 2130)))
{

 if(limitebuy == vbid && cmbord == 0 ) //reverse
   {
   if(!(cmbord == 2))
   {
      lot();
     OrderSend(Symbol(),OP_SELL,lots,Bid,3,0,0,"shel",0,0,Red);
     timesell = Time[0];
    cmbord=cmbord+1;
    }
   }
   
   
   
}
      
   //----
   for(int iclo=0;iclo<OrdersTotal();iclo++)
     {
      if(OrderSelect(iclo,SELECT_BY_POS,MODE_TRADES)==true){
 /*     if(OrderType()==OP_BUY)
        {
         if(Open[1]>ma && Close[1]<ma)
           {
            if(!OrderClose(OrderTicket(),OrderLots(),Bid,3,White))
               Print("OrderClose error ",GetLastError());
           }
         break;
        }*/
        
      if(OrderType()==OP_SELL)
        {
      //  Print("Profit for the order ",OrderProfit());
         if(OrderProfit() >= 30.0 * lots)
           {
            if(!OrderClose(OrderTicket(),OrderLots(),Ask,3,White)){
               Print("OrderClose error ",GetLastError());
               }
            else
               cmbord=cmbord-1;
           }
        }
        
       
        
        
         if (TimeCurrent()-timesell>=300)
       {
         if(OrderProfit() >= 20 * lots)
           {
            if(!OrderClose(OrderTicket(),OrderLots(),Ask,3,White)){
               Print("OrderClose error ",GetLastError());
               }
            else
               cmbord=cmbord-1;
             
           }
       }
       
        
        
         if (TimeCurrent()-timesell>=600)
       {
         if(OrderProfit() >= 7 * lots)
           {
            if(!OrderClose(OrderTicket(),OrderLots(),Ask,3,White)){
               Print("OrderClose error ",GetLastError());
               }
            else
               cmbord=cmbord-1;
             
           }
       }
        if (TimeCurrent()-timesell>=700)
       {
         if(OrderProfit() >= 0.1 * lots)
           {
            if(!OrderClose(OrderTicket(),OrderLots(),Ask,3,White)){
               Print("OrderClose error ",GetLastError());
               }
            else
               cmbord=cmbord-1;
             
           }
       }
      /*
       if (TimeCurrent()-timesell>=900)
       {
         if(OrderProfit() >= 5.0)
           {
            if(!OrderClose(OrderTicket(),OrderLots(),Ask,3,White)){
               Print("OrderClose error ",GetLastError());
               }
            else
               cmbord=cmbord-1;
             
           }
       }
       
        if (TimeCurrent()-timesell>=1800)
       {
         if(OrderProfit() >= -25.1)
           {
            if(!OrderClose(OrderTicket(),OrderLots(),Ask,3,White)){
               Print("OrderClose error ",GetLastError());
               }
            else
               cmbord=cmbord-1;
             
           }
       }

/*
  if (TimeCurrent()-timesell>=3300)
       {
         if(OrderProfit() >= -60.1)
           {
            if(!OrderClose(OrderTicket(),OrderLots(),Ask,3,White)){
               Print("OrderClose error ",GetLastError());
               }
            else
               cmbord=cmbord-1;
             
           }
       } 
       /*
        if (TimeCurrent()-timesell>=9600 )
       {
         if(OrderProfit() >= -150.1)
           {
            if(!OrderClose(OrderTicket(),OrderLots(),Ask,3,White)){
               Print("OrderClose error ",GetLastError());
               }
            else
               cmbord=cmbord-1;
             
           }
       }
        
*/
        
        
        
        //****
        /*
       if (TimeCurrent()-timesell>=1*60*60)
       {
         if(OrderProfit() >= -20.1)
           {
            if(!OrderClose(OrderTicket(),OrderLots(),Ask,3,White)){
               Print("OrderClose error ",GetLastError());
               }
            else
               cmbord=cmbord-1;
             
           }
       }*/
             
             
  /*      if (TimeCurrent()-OrderOpenTime()>5*60*60)
       {
          OrderClose(OrderTicket(),OrderLots(),Ask,3,White);
          cmbord=cmbord-1;
       }*/
       
       
       
        
        
        
        
        
        
        
        
        
        
        
         if(-350.0*lots >= OrderProfit() && urgent == 0)
        {
        
        urgent = 1;
        }
        
        if(urgent == 1)
        {
             if (TimeCurrent()-timesell>=4200)
            {
            if(-50.0*lots <= OrderProfit())
           {
            OrderClose(OrderTicket(),OrderLots(),Ask,3,White);
            cmbord=cmbord-1;
            urgent = 0;
           
           }
       
        }
        
        }
        
        
        
        
        
        
        
        if(-1000.0*lots >= OrderProfit() && urgent == 1)
        {
        
        urgent = 2;
        }
        
        if(urgent == 2)
        {
             if (TimeCurrent()-timesell>=4200)
            {
            if(-170.0*lots <= OrderProfit())
           {
            OrderClose(OrderTicket(),OrderLots(),Ask,3,White);
            cmbord=cmbord-1;
            urgent = 0;
           
           }
       
        }
        
        }

        
       
       

        
        }
     }
     //----







   
  }
//+------------------------------------------------------------------+
