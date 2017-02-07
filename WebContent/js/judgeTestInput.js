 function IsSubmit(obj)
      {
          var singleCount = document.getElementsByName("singleCount")[0];
          var perSingle = document.getElementsByName("perSingle")[0];
          var multiplyCount = document.getElementsByName("multiplyCount")[0];
          var perMultiply = document.getElementsByName("perMultiply")[0];
          var judgeCount = document.getElementsByName("judgeCount")[0];
          var perJudge = document.getElementsByName("perJudge")[0];
          var jdCount = document.getElementsByName("jdCount")[0];
          var perJd = document.getElementsByName("perJd")[0];
          var programCount = document.getElementsByName("programCount")[0];
          var perProgram = document.getElementsByName("perProgram")[0];
          var totalTime = document.getElementsByName("totalTime")[0];
          if(singleCount.value=="")//判断单选题总数输入框输入不能为空
          {
            alert("请输入单选题总数！");
            singleCount.focus();
          }else if(isNaN(singleCount.value))//判断单选题总数输入框输入只能是数字
          {
            alert("不是合法的数字!");
            singleCount.focus();
          }
          else if(perSingle.value=="")//判断单选题分值输入框输入不能为空
          {
            alert("请输入单个单选题分数");
            perSingle.focus();
          }else if(isNaN(perSingle.value))//判断单选题分值输入框输入输入只能是数字
          {
            alert("不是合法的数字!");
            perSingle.focus();
          }
          else if(multiplyCount.value=="")//判断多选题总数输入框输入不能为空
          {
            alert("请输入多选题总数！");
            multiplyCount.focus();
          }else if(isNaN(multiplyCount.value))//判断多选题总数输入框输入只能是数字
          {
            alert("不是合法的数字!");
            multiplyCount.focus();
          }
          else if(perMultiply.value=="") //判断多选题分值输入框输入不能为空
          {
            alert("请输入单个多选题分数！");
            perMultiply.focus();
          }else if(isNaN(perMultiply.value))//判断多选题分值输入框输入只能是数字
          {
            alert("不是合法的数字!");
            perMultiply.focus();
          }
          else if(judgeCount.value=="") //判断判断题总数输入框输入不能为空
          {
            alert("请输入判断题总数！");
            judgeCount.focus();
          }else if(isNaN(judgeCount.value))//判断判断题总数输入框输入只能是数字
          {
            alert("不是合法的数字!");
            judgeCount.focus();
          }
          else if(perJudge.value=="")//判断判断题分值输入框输入不能为空
          {
            alert("请输入单个判断题分数！");
            perJudge.focus();
          }else if(isNaN(perJudge.value))//判断判断题分值输入框输入只能是数字
          {
            alert("不是合法的数字!");
            perJudge.focus();
          }
          else if(jdCount.value=="")//判断简答题总数输入框输入不能为空
          {
            alert("请输入简答题总数！");
            jdCount.focus();
          }else if(isNaN(jdCount.value))//判断简答题总数输入框输入只能是数字
          {
            alert("不是合法的数字!");
            jdCount.focus();
          }
          else if(perJd.value=="")//判断简答题分值输入框输入不能为空
          {
            alert("请输入单个简答题分数！");
            perJd.focus();
          }else if(isNaN(perJd.value))//判断简答题分值输入框输入只能是数字
          {
            alert("不是合法的数字!");
            perJd.focus();
          }
          else if(programCount.value=="")//判断编程题总数输入框输入不能为空
          {
            alert("请输入编程题总数！");
            programCount.focus();
          }else if(isNaN(programCount.value))//判断编程题总数输入框输入只能是数字
          {
            alert("不是合法的数字!");
            programCount.focus();
          }
          else if(perProgram.value=="")//判断编程题分值输入框输入不能为空
          {
            alert("请输入单个编程题分数！");
            perProgram.focus();
          }else if(isNaN(perProgram.value))//判断编程题分值输入框输入只能是数字
          {
            alert("不是合法的数字!");
            perProgram.focus();
          }
          else if(totalTime.value=="")//判断考试总时间输入框输入不能为空
          {
            alert("请输入考试总时间！");
            totalTime.focus();
          }else if(isNaN(totalTime.value))//判断考试总时间输入框输入只能是数字
          {
            alert("不是合法的数字!");
            totalTime.focus();
          }
          else{
              var totalscore = parseInt(singleCount.value)*parseInt(perSingle.value)+parseInt(multiplyCount.value)*parseInt(perMultiply.value)
              +parseInt(judgeCount.value)*parseInt(perJudge.value)+parseInt(jdCount.value)*parseInt(perJd.value)+
              parseInt(programCount.value)*parseInt(perProgram.value);
              //alert(totalscore);
              if(totalscore!=100)
              {
                var key = confirm("总分不等于100分，确定提交？");
                if(key)
                {
                 document.forms[0].submit();
                }
             }else
              {
               if(obj.value=="修改")
               {
                var okey = confirm("确定修改？");
                if(okey)
                {
                 document.forms[0].submit();
                }
               }else
               {
                 document.forms[0].submit();
               }
             }
           }
        }