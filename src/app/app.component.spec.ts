import { ComponentFixture, TestBed } from '@angular/core/testing';
import { AppComponent } from './app.component';

describe('AppComponent', () => {
  let fixture: ComponentFixture<AppComponent>
  beforeEach(async () => {
    await TestBed.configureTestingModule({
      imports: [AppComponent],
    }).compileComponents();
    fixture = TestBed.createComponent(AppComponent);
    fixture.detectChanges();
  });

  

  it('devrait afficher Bonjour ', ()=>{
    const compliled = fixture.nativeElement as HTMLElement;
    expect(compliled.querySelector('h1')?.textContent).toContain('Bonjour');
  })




});
