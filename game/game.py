import numpy as np



def move(where,state,portal,broken_ice):
    if(where == 'up'):
        
        sorted_state=dict(sorted(state.items() ,key = lambda index : index[1][0],reverse=False))
        occupied=[]
        for key,value in sorted_state.items():
            new_occupied=occupied.copy()
            if(key != 'me'): 
                new_occupied.extend([portal])
            new_pos=move_shift(value,new_occupied,broken_ice,lambda x: (x[0]-1,x[1]))
            occupied.append(new_pos)
            state[key]=new_pos
            
    elif(where == 'down'):
        
        sorted_state=dict(sorted(state.items(),key = lambda index : index[1][0],reverse=True))
        occupied=[]
        for key,value in sorted_state.items():
            new_occupied=occupied.copy()
            if(key != 'me'): 
                new_occupied.extend([portal])
            new_pos=move_shift(value,new_occupied,broken_ice,lambda x: (x[0]+1,x[1]))
            occupied.append(new_pos)
            state[key]=new_pos
        
    elif(where == 'right'):
       
        sorted_state= dict(sorted(state.items(),key = lambda index : index[1][1],reverse=True))
        occupied=[]
        for key,value in sorted_state.items():
            new_occupied=occupied.copy()
            if(key != 'me'): 
                new_occupied.extend([portal])
            new_pos=move_shift(value,new_occupied,broken_ice,lambda x: (x[0],x[1]+1))
            occupied.append(new_pos)
            state[key]=new_pos
        
    elif(where == 'left'):
        
        sorted_state= dict(sorted(state.items(),key = lambda index : index[1][1],reverse=False))
        occupied=[]
        for key,value in sorted_state.items():
            new_occupied=occupied.copy()
            if(key != 'me'): 
                new_occupied.extend([hammer,portal])
            new_pos=move_shift(value,new_occupied,broken_ice,lambda x: (x[0],x[1]-1))
            occupied.append(new_pos)
            state[key]=new_pos
    
    return state
    
        


def move_shift(old_pos,occupied,broken_ice,step):
    next_pos=step(old_pos)
    if(next_pos in occupied or 
       (next_pos[0]<0 or next_pos[0]>7 or next_pos[1]<0 or next_pos[1]>7 or
       game[next_pos[0],next_pos[1]]==2 and next_pos not in broken_ice) or
       game[next_pos[0],next_pos[1]]==1):
        return old_pos
    else:
        return move_shift(next_pos,occupied,broken_ice,step)

def remove_ice(state,broken_ice):
    row_i=state['me'][0]
    col_i=state['me'][1]
    if(row_i-1>=0):
        if(a[row_i-1,col_i] == 2.0):
            broken_ice.append((row_i-1,col_i))
    if(row_i+1<8):
        if(a[row_i+1,col_i] == 2.0):
            broken_ice.append((row_i+1,col_i))
    if(col_i+1<8):
        if(a[row_i,col_i+1] == 2.0):
            broken_ice.append((row_i,col_i+1))
    if(col_i-1>=0):
        if(a[row_i,col_i-1] == 2.0):
            broken_ice.append((row_i,col_i-1))
    return broken_ice

def transform(actions,state,have_hammer,portal,broken_ice):
    for az in actions:
        state=move(az,state,portal,broken_ice)
        if(state['me']==hammer): 
            have_hammer=1
        if(have_hammer==1): broken_ice = remove_ice(state,broken_ice)
    return state,have_hammer,broken_ice

def draw(state,matrix,have_hammer,broken_ice):
    for i,row in enumerate(matrix):
        for j,el in enumerate(row):
            
            if(state['me']==(i,j)):  print("|IO|", end = '')
            elif(state['g1']==(i,j)):print("|G1|" , end = '')
            elif(state['g2']==(i,j)):print("|G2|" , end = '')  
            elif(state['g3']==(i,j)):print("|G3|" , end = '')
            elif(hammer==(i,j) and have_hammer==0):     print("|+H|" , end = '') 
            elif(portal==(i,j)):     print("|@ |", end = '')   
            elif(el == 1.0):         print("|##|", end = '')  
            elif(el == 0.0 or (i,j) in broken_ice):         print("|  |", end = '') 
            elif(el == 2.0 and (i,j) not in broken_ice):         print("|**|", end = '') 
            
        print(" ") 
    if(have_hammer==1): print("You have a hammer")

a = np.zeros((8,8))


a[0,5]=1
a[1,1]=1
a[1,7]=1
a[2,7]=1
a[3,3]=1
a[3,4]=1
a[4,4]=1
a[5,1]=1
a[6,1]=1
a[6,5]=1
a[7,2]=1

a[1,5]=2
a[1,6]=2
a[6,6]=2
a[3,6]=2
a[4,7]=2

a_hammer=(7,1)
a_portal=(3,7)

a_state={'me':(0,3),'g1':(0,6),'g2':(4,3),'g3':(7,7)}


game=a
hammer=a_hammer
portal=a_portal
state=a_state
broken_ice=[]
have_hammer=0

print("BEFORE")
draw(state,game,have_hammer,broken_ice)

#[down,left,down,right,left,up,right,down,right,down,right,up]
test=["down","left","down","right","left","up","right","down","right","down","right","up"]
test
state,have_hammer,broken_ice=transform(test,state,have_hammer,portal,broken_ice)

print("THEN")
draw(state,game,have_hammer,broken_ice)

