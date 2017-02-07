function init()
{
  setAnswer();
  judgeCourse();
}
function setAnswer()
{
  var type=document.getElementsByName("type")[0];
  var answer_sin = document.getElementById("answer_sin");
  var answer_mul = document.getElementById("answer_mul");
  var answer_judge = document.getElementById("answer_judge");
  var other = document.getElementById("other");
  var choiceA = document.getElementById("choiceA");
  var choiceB = document.getElementById("choiceB");
  var choiceC = document.getElementById("choiceC");
  var choiceD = document.getElementById("choiceD");
  if(type.selectedIndex==0)
  {
    answer_sin.style.display="block";
    answer_mul.style.display="none";
    answer_judge.style.display="none";
    other.style.display="none";
    choiceA.style.display="block";
    choiceB.style.display="block";
    choiceC.style.display="block";
    choiceD.style.display="block";
  }else if(type.selectedIndex==1)
  {
   answer_sin.style.display="none";
    answer_mul.style.display="block";
    answer_judge.style.display="none";
    other.style.display="none";
    choiceA.style.display="block";
    choiceB.style.display="block";
    choiceC.style.display="block";
    choiceD.style.display="block";
  }else if(type.selectedIndex==2)
  {
    answer_sin.style.display="none";
    answer_mul.style.display="none";
    answer_judge.style.display="block";
    other.style.display="none";
    choiceA.style.display="none";
    choiceB.style.display="none";
    choiceC.style.display="none";
    choiceD.style.display="none";
  }else
  {
   answer_sin.style.display="none";
    answer_mul.style.display="none";
    answer_judge.style.display="none";
    other.style.display="block";
    choiceA.style.display="none";
    choiceB.style.display="none";
    choiceC.style.display="none";
    choiceD.style.display="none";
  }
}
function edit(obj)
{
  obj.innerHTML="";
}
function judgeCourse()
{
  var choice = document.getElementsByName("kemu");
  var discourse="course";
  var course="course";
  for(var i=0;i<choice.length;i++)
  {
    if(choice[i].checked==true)
    {
      course=course+choice[i].value;
    }else
    {
      discourse = discourse+choice[i].value;
    }
  }
  var tag_course = document.getElementsByName(course)[0];
  var tag_discourse = document.getElementsByName(discourse)[0];
  tag_course.disabled = false;
  tag_discourse.disabled=true;
}
function IsSubmit()
{
  var choice = document.getElementsByName("kemu");
  var course="course";
  for(var i=0;i<choice.length;i++)
  {
    if(choice[i].checked==true)
    {
      course=course+choice[i].value;
    }
   }
  var tag_course = document.getElementsByName(course)[0];
  var ques = document.getElementsByName("ques")[0];
   var type=document.getElementsByName("type")[0];
   var answer="";
   if(type.selectedIndex==0)//单择题
   {
    var answer_choice = document.getElementsByName("answer_sin");
    for(var i = 0;i<answer_choice.length;i++)
    {
      if(answer_choice[i].checked)
      {
        answer = answer_choice[i].value;
      }
    }
    }else if(type.selectedIndex==1)//多选题
   {
    var answer_choice = document.getElementsByName("answer_mul");
    for(var i = 0;i<answer_choice.length;i++)
    {
      if(answer_choice[i].checked)
      {
        answer = answer+answer_choice[i].value;
      }
    }
   }else if(type.selectedIndex==2)//判断题
   {
    var answer_choice = document.getElementsByName("answer_jud");
    for(var i = 0;i<answer_choice.length;i++)
    {
      if(answer_choice[i].checked)
      {
        answer = answer_choice[i].value;
      }
    }
   }else
   {
     answer = document.getElementsByName("answer_other")[0];
   }
  
  if(tag_course.value=="0"||tag_course.value=="")
  {
    alert("请输入科目！");
  }else if(ques.value=="")
  {
    alert("请输入题干！");
    ques.focus();
  }else if(answer=="")
  {
    alert("请输入正确答案!");
  }
  else 
  {
    var key = confirm("确定操作？");
    if(key==true)
    {
     document.forms[0].submit();
    }
  }
}